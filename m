Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033E606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TX3+fWPm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MaSTkU5X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xObvd-0000tt-Ii; Wed, 04 Nov 2026 09:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xObvb-0000tf-JC
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:25:27 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xObvZ-0000yJ-Ly
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:25:27 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4EI1XQ3079442
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 14:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CUR0vUKMZAOsON6Q/xzi9wjN3J/PrcDZDfGX5jo5XeI=; b=TX3+fWPmq/tDvoZX
 1U6/ni7QR3rUqzZEy7Y1yEjfXkjnnITXUn44YlMh5FbCVGyfOPlk2rBuISDPeqYS
 e/NIrpz10fteI1uCyjn6UqX+tZetZM8yBuLA36EFFYuuIK+WeILBwnuxyPc+tIF9
 d2dm++kdI5h77xDfRYEirHRf0YTDh8vNGus0/BL7O1l2EVqy/JlCHvDxTYhiv2JY
 V5oYAoyrG5lBbCE+YxS6LIwF0ncfNr7xHIaIR1+NNevKWf8XwqOiVlf0l9g7tTx6
 W6pz0+DH+2Uw5OtlJstu9/h4KPCFqqJFNa9Xtqc5aYFuDIJVqXo+bsNOw66qnClZ
 IKpg+w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bng0u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:25:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36d2d353a5aso482313eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793802322; x=1794407122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CUR0vUKMZAOsON6Q/xzi9wjN3J/PrcDZDfGX5jo5XeI=;
 b=MaSTkU5XrGMj/n3IuLWmLPLh/cZ5UzZ/4rQTm+zNY8MmVBmLhfsZrL0o06hmb6QelP
 92yS/c+2uWZnKankNa98Y6VHT3FUgL1sk71Ig4JF8jJMIycWmbHT3z+MnAb7TKeztfP9
 emF9Rf8hnurQ0HyVMhUThX0gkVvLNttmjK/trW9UCU8tDGhYqAMCju4Gtq/bnKHyl27o
 X962+2ErlMc4OFxH8WVJDJ+PyvSpj2iYBDyUKkfqngocn6wnQUQ4ssjX7yDWZzo45s+O
 xhnBacqDVFPiyL80zKBZImNtcecfup0sxt854YdTjDlfBaSc2mHL93E7bngaRLaldiYQ
 KYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793802322; x=1794407122;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CUR0vUKMZAOsON6Q/xzi9wjN3J/PrcDZDfGX5jo5XeI=;
 b=IOj63uRt5YzcdP6F2p61c9E0EpxTvxBpOw5eR4LWdqaX8ZYxqJ5wPBVP5L1SJqzIHw
 x2f+E4++hGmkmHDM/sP2DChlc1gS7dEjG5cDHyRPdClqAdF+lZ3GsM3nhk1eQNZlA1ej
 APVacAu+dnQm/PhG4SB+IBQi9tYHpA0FBAINzgBZYHJMttPH0+FdUrs+scACxXWjrmnk
 donYbT2Tdc1SD+oIoqtnLH9cgKM/BYGYDg/WrninxT8gE14YtFOkjC4LFXtLA1rnz96u
 neQ3P5TmKBHa4rDJetI9Uvvu4nbJL/pgStLLr8kkLQG6LAs3gIPRBk+YqlU4YLvCedP2
 RW2g==
X-Gm-Message-State: APuU4Z+cLdRULxhQU/MXsnZMfmjGDj7gy2bwzYBtYWtlZq11HOFK2Q6H
 3Ccjg3Fw00ZAspN3x7wNND+7/p8UgGUS4eFCsdkKrmuXQ0xi5qgcr+W8Yf9hftpRiiZ1jsyBxu7
 oxHoE1eskpWxEGDdKJCjfckNARUpLcASahn3FIc0ElpdYT4SMQU1SKh9RxL89+SDDVA==
X-Gm-Gg: AYBFou0mwGNhEfwNBAIaxZVVd5VfKNqSWzvVx+eGNz9C26OLiFf02Je5yHaoqHa1RjT
 9evuoDxtlmDNO1tuLY3Vh/yG/8ZF+zDgJ1++/f5bVAhuAxsD7Fg5GllAhgiEd4U+Ox8ltZq7fMu
 reZJMDHDu451KnPiZiVpIh+2Zr3myVYXUl24wcbknmCe1mPqN/sZ6jiCRe0blMZsTVLFyTr69+e
 +W/YGkC7kMZBNid2veJeX7q2+yQ9JkxliXpGMGPKkeC+A9CNLNL/efNiAypfTvmubJ7S5DTbed8
 357PmwC5zB7m8oY6lK4Mptf3HXoy7R9rajE1mEUkhWHxipALKKmMacE12ChA1u5vKIBSxWHJqgj
 VOn/Qm5j6g9bF/AjPhPsZG5CCMTm68ulnQTfB9OU0dtGKhQSWCELXOL1ztdh94mHJAWYmt26Idx
 mzhcnXm7gw
X-Received: by 2002:a05:7301:92a:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-36d158ce72bmr1869975eec.18.1793802321358; 
 Wed, 04 Nov 2026 06:25:21 -0800 (PST)
X-Received: by 2002:a05:7301:92a:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-36d158ce72bmr1869805eec.18.1793802318670; 
 Wed, 04 Nov 2026 06:25:18 -0800 (PST)
Received: from [172.20.2.143] ([192.210.17.203])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca39b8eb3sm10565315eec.27.2026.11.04.06.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 06:25:17 -0800 (PST)
Message-ID: <77c5a6a9-a92b-4653-82ae-05815ec0af83@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 06:25:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: reset supported features on Supported request
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 brian.cain@oss.qualcomm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Justin Sapp <jsapp@qti.qualcomm.com>
References: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfXxXk+Ugyft4oP
 M+dma3Ug1AaREUM14EQZ966B1DBwI3vkcp+RU8egYVi6DuKjCB2NO2J6F/+7bo6SoiE836R0yJ1
 Rtam+kvSNsfeF0oqriW4uKuQLfrs357KhuxklJWBcLRDXdOyfbEYAdJozMcjIWRZ1goNrmFsaX7
 O9Vz20Rejn3pJjXMCXwGsWZPx06Efn+F6l5YdM53185GeR6z8M5KiXCiTvN/Gg9rruIPWdWLdRr
 dheo0JgxwYsYQMMy4ldVDFEpNIM5HYZarGNAsW18gfULC/lfLfQVxzrPlE5X+bKC/848KimRd4X
 cP18BOeE3XwKeXWtfxzfd+DYI1a/Qomc/5mVoe0ECkqyObkuwl90KB1yqpiD6sXS9kP/GAtvUCE
 BCrRaWnr7DyKnNJId05y4PypAl1N7SY13HkTLqWbYi0DKKx6YwKjaJ9CG3LMkTt8/uxfPpTKvg9
 zrlw56zDZBqIOKvzVOQ==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aeb4052 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=3CSVYe8HblTQFsWiJzwA3g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=p8_FKq9acrWjzv0kNlIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-ORIG-GUID: mOhWskNBV9Oq0_AFDbwzDhJxwv4ugoaJ
X-Proofpoint-GUID: mOhWskNBV9Oq0_AFDbwzDhJxwv4ugoaJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfX4wLlyucT5hMo
 Ab/cR/qq6L0wjX1pFMVNc8JlGzZWtP+mIXuKhoZpusuahAXtxbUumJuNqKLD9xQOtGKmWDE4RK4
 9slyViEgi2kwYf2U6QI/l84i/FNy6do=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040056
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/2026 3:21 PM, Pierrick Bouvier wrote:
> From: Justin Sapp <jsapp@qti.qualcomm.com>
> 
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
> ```
> Whenever the stub receives a ‘qSupported’ request, the supplied set
> of GDB features should override any previous request. This allows GDB to
> put the stub in a known state, even if the stub had previously been
> communicating with a different version of GDB.
> ```
> 
> We exposed this by connecting to gdbstub using a gdb client first, and
> then WinDbg (EXDI) for windows kernel debugging. Since they both
> differ in their multiprocess support, this was confusing EXDI.
> 
> While we are here, fix the same for fork_events in user mode.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  gdbstub/gdbstub.c | 6 ++++++
>  gdbstub/user.c    | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 0a328b0dd48..dbb2000c817 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1679,6 +1679,12 @@ void gdb_extend_qsupported_features(char *qflags)
>  
>  static void handle_query_supported(GArray *params, void *user_ctx)
>  {
> +    /*
> +     * Reset multiprocess support as a new gdb client may have different support
> +     * than a previous one.
> +     */
> +    gdbserver_state.multiprocess = false;
> +
>      g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
>      if (gdb_get_core_xml_file(first_cpu)) {
>          g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index d810f0f38c3..9b6d42d210a 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -701,6 +701,7 @@ fail:
>  
>  void gdb_handle_query_supported_user(const char *gdb_supported)
>  {
> +    gdbserver_user_state.fork_events = false;
>      if (strstr(gdb_supported, "fork-events+")) {
>          gdbserver_user_state.fork_events = true;
>      }

Ping on this patch.
@Alex: I noticed you have an 11.2 series going on, this could be nice if
we had a chance to add this patch there also.

Regards,
Pierrick

