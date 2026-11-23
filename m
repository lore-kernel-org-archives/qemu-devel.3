Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B9606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ol0EN27Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BdeTTFpW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVY1L-0007Kl-Mq; Mon, 23 Nov 2026 12:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVY1J-0007KD-C9
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:40:01 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVY1H-0002RF-2h
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:40:00 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGH9VE2377537
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 592/ITt1Xg/VKamM6QIcgO5OCqCrGFR8lkiO0ycsrC4=; b=Ol0EN27QaFIL1TRw
 KQm5fEJczbbl+akRdnIOe5Nkl0+FDdwtkKtDGZoCGkE6kZv1q99gg4n+snNlm1wC
 GcCOxIea6WAbC4g/kyHHusVyu+VKPZisnIEgtwuSKXRxKTEVT7thhaM/Z2BEeeMw
 zQf+WWbi1u+LUVku9E3mt+vZ0g80SLQ9dgdlNswqzsN1KSJTMAwjmq7l3ssPc9T3
 5ly+4huppTopIpFnaZFGZC78WAMkUujOR6G6szUHThavIllQXEAFLvuGUVoTxA/V
 VOtTII1JVPe2qwclRlv9g7GgiDIVbLFa88k3ctAmuitu0sQE0vuo2g+I2Otx0pcC
 vNKTlw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7usk1j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:39:57 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so713427785a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795455596; x=1796060396; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=592/ITt1Xg/VKamM6QIcgO5OCqCrGFR8lkiO0ycsrC4=;
 b=BdeTTFpWFyzy2Ldl7qtqooBZ5CqK4p5EsJO8WBuGfH+vDNNLJii8BBgK6fzb3bqJ50
 0vqc4tStW8l1mYZLQaYmv9DBb3VgpQKh3q0VnoEjGNHlmksYV8PEy3/MYH/finddoteI
 1wupqHZWP2HbFv5pXH2kyaoUx1UgTM527cPARqFJhJN9r/Djtz9ldflfR0NEJFzJI7nM
 IS66FIFsUIf0MzvZRby7XPfbYFuCa4IxBwKSHRL5yP+ptfvrZcB0qONBhq6kwaayKjHI
 FavDPaTw6rRrP0wfVbz1ZEx94Z4R38V3vDUSnsKUCTavA/vdGboTucdsEn+CPQFI8l0D
 oCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795455596; x=1796060396;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=592/ITt1Xg/VKamM6QIcgO5OCqCrGFR8lkiO0ycsrC4=;
 b=tcWOkXCBvnCsFAGfPDZtYnQ6pTNPMCJfwHWH1DqyI7VnNBIYgZHLKwue+q7hMEbJHY
 gPimtm8ocbZTAxPiRB49sbPaHRG4hMyWs7dOZLb+F1PsZ6d4JMzL71JHLk9inrL0Q/j2
 J7DKDr1M+BS6OK9Qm61IO+3d42yaza2wRu31frs7IXL+qxC//LXXYsFnx4k8uqxyB854
 h+DFA1mAj2r5d6MkojbYP7uvKgjT5MexYpOZW0Trou9IGKWA5qikbf9BakvYBF8zBboF
 jUirGPSKjLps5lDfeQXJyHA3re/XVgMDMtKgBTwWNF/et8ZqWjySrhwWGpJrTapTYim+
 GtEg==
X-Forwarded-Encrypted: i=1;
 AL+hErF6QE4LYL3a/lazAnMr3I/ZBFGKoLHizIKgGepxb6KXxOitgep5rE/ZEktddq6vzHU1izzNsOFxegnW@nongnu.org
X-Gm-Message-State: APuU4Z+05mwdN727RTKrW5wiU/ae7DOZmEF0AfM4CIxpi8Olti/5f5ij
 4YHUSWul1P3pmtb/G9/J1jzLAFUnjkM6HxjA5CIXfrCk/23azA2HFthGK6FB7E/z64oPNl3PfLL
 mMOjtZebGzD9SfKs7uT6EcUnDdAkjnv9FbspscJ2IxP7I448DWknLV2jkrA==
X-Gm-Gg: AZFdTZc74ry7S9ozJxTpyD3IzCpKasVI0qaKyz/pPKTjRcbCsdXDF1UC7Hok6/9ty1X
 P5KGxBy4XitWeXFYznIc7i+NdEb30KYFy4T/6+rfqc89E8YuJGhtGZUtD9R/36QgsQL6COG3Hre
 1+7s4Pj05k400LNltLbEfhvBBxMhVGkoY7o1RPxBlHn38Ekl/5Ga0FBGAN02Ysvwilb5glVwK0L
 z+GOkqDVaYgTK+Vp4ZUmRmswa6++orbSFP7/yLIp0XQkdPM3QPktuYLhlVdNEiitJS6Zqf4a5ES
 6O5OcueNXzH32T+VR36fx7/u5/1nQHEJVtecqLyTdA88VSEgKzmTPTpesnzqCQINKu6EIVj6wad
 nV2Hb7ghZIZLoD4LLxRFdQBKF2PgrCC+sH07uHDJbHSxARh14NpEaYl2dZvnvfFXMtqQGheDM1U
 VJm/Mxht0=
X-Received: by 2002:a05:620a:8396:b0:944:192:85ef with SMTP id
 af79cd13be357-949ba95dfc3mr1954117585a.22.1795455596344; 
 Mon, 23 Nov 2026 09:39:56 -0800 (PST)
X-Received: by 2002:a05:620a:8396:b0:944:192:85ef with SMTP id
 af79cd13be357-949ba95dfc3mr1954111885a.22.1795455595682; 
 Mon, 23 Nov 2026 09:39:55 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm319017565e9.1.2026.11.23.09.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:39:54 -0800 (PST)
Message-ID: <d3e3780b-5044-42f8-bda0-7e240848762b@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 18:39:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gdbstub: reset supported features on Supported request
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 brian.cain@oss.qualcomm.com, Justin Sapp <jsapp@qti.qualcomm.com>
References: <20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gq868a7qSAQl6721duGccmO8ZTh56Vfe
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b047a6d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=foSLsXMM6AXmFfwpkUUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: Gq868a7qSAQl6721duGccmO8ZTh56Vfe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX49pX3XIwhxNS
 QKTvUWrXE9sUJjj03sJeTxrgLk5slXshx0H+JokedikvRbKp72huSe8q698XRWcnUP6/9EMe3Vs
 b3VZMZHK+Nojfj+BicfLYJw3fQa+mF4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MCBTYWx0ZWRfX7S+SFpzzgvfs
 C2nlen8BCaN7nGYVCrW6Idawy/7JorGu/6XTqxsWcFHGH+IQ7ucZIDSD34RA98TWO9HQEEK3kmW
 Ka1sNSyXFpHaUPNbRnwtU9QZ9sehqFx3IZlC/mGlYPrASvMGcRzaiujgNHyQsjEs9c9Lw7nIys4
 BoB43QWGImhMf/Yre7J2DXwAx/jc3A1v6nvir+07D9U+FTle+T2g9nf0LAiQ1PjMXxj2Q0V6/1w
 qfHM/EhPQYJKL1VyXAsasLvKaiQY5/eIni3wdc4y7dzu7DZBlu0c74u/eS9C8my1JngOom0Mbwt
 XhaaFqgTS1kLXsUaZXgHnSl6qCXdfLxECQrvSevfeWvrx3POj7N+W/aNRsynq5Pc71xFVVjIkR6
 tysLgcEEYImLCLCq81BVMJ9TO66mGSiKQ2HPcsSowmEAu7OHj7e+a8Rl8rqcLtyvxohv6znjixh
 YnNdpJY1ByaHYi0iEhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 5/11/26 08:53, Pierrick Bouvier wrote:
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
> Simplify control flow to always call gdb_handle_query_supported_user.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   gdbstub/gdbstub.c | 15 +++++++--------
>   gdbstub/user.c    |  4 +---
>   2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 0a328b0dd48..38fe56a5d36 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1679,6 +1679,11 @@ void gdb_extend_qsupported_features(char *qflags)
>   
>   static void handle_query_supported(GArray *params, void *user_ctx)
>   {
> +    const char *gdb_supported = "";
> +    if (params->len) {
> +        gdb_supported = gdb_get_cmd_param(params, 0)->data;
> +    }
> +
>       g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
>       if (gdb_get_core_xml_file(first_cpu)) {
>           g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
> @@ -1701,16 +1706,10 @@ static void handle_query_supported(GArray *params, void *user_ctx)
>       g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
>   #endif
>   
> -    if (params->len) {
> -        const char *gdb_supported = gdb_get_cmd_param(params, 0)->data;
> -
> -        if (strstr(gdb_supported, "multiprocess+")) {
> -            gdbserver_state.multiprocess = true;
> -        }


> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index d810f0f38c3..6526200a360 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -701,9 +701,7 @@ fail:
>   
>   void gdb_handle_query_supported_user(const char *gdb_supported)
>   {
> -    if (strstr(gdb_supported, "fork-events+")) {
> -        gdbserver_user_state.fork_events = true;
> -    }
> +    gdbserver_user_state.fork_events = strstr(gdb_supported, "fork-events+");

Per-existing style, != NULL would be more explicit.

>       g_string_append(gdbserver_state.str_buf, ";fork-events+");
>   }
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


