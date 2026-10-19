Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F8D606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Up1t3CO4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MQJdtcix
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIu3l-0001wM-Dj; Mon, 19 Oct 2026 16:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIu3h-0001wA-4u
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:34:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIu3f-0001bU-Bc
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:34:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJt3e3474932
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 20:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9O0isZqxf9nkw1WQ4Y4OYTlaB7mcAfmGj74MlWzLwnU=; b=Up1t3CO4OUTTuoup
 gKyhDXsGDkHG5yi79dqVEzts6Vez+1VcyRSvQc8p4XDOP+KaAeAa/Hm6mOSkZ0uV
 5zOM0xOngm9IbS8f0tTGVb7tEH/B6lpA56rv86+GbjXLXDdKb1TnEQiyJN4xEejc
 fV0Dck2FcSw1W6/Tjlm0T1l+vMLljXlxBvj+7QNcCUyOcFActBGWcN0ZjcKss9sh
 TDNAl5HFdlNVjHMDpGEiuo1VvW7OlesrejXEVJ83ySvNYhlfE3lU2/EIZQgPw2RV
 o5I7l26zUekJS/m4sNSpeRs0vVwY/fJyBez31jfZb+JKOgykpudvtbxC2PxBEL0q
 3O2Xfg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdqtf8n7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 20:34:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1665200f4c2so3536852c88.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792442049; x=1793046849; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9O0isZqxf9nkw1WQ4Y4OYTlaB7mcAfmGj74MlWzLwnU=;
 b=MQJdtcixURo3yhHaBB+Jb59kgSa5GVHa3Q9DDmTMVDS9kQRuQPdjg+8os5lb7e+edZ
 yk55nYR2hxueFLKBy2JqdqikkcHCfNiCGreFJLc+tke9shKIk09zUWE+Gs9fz/yVu/GK
 Oc5ySAYQ1s6mvtTn58QYGSvujVNlEtD1d+okcSo/IHyuB7dBhgcXfBulVHCZC5QwGvgb
 ME1khLNBaBTUuQ4V4b7lUmERykoVWA9tJ+lpoeIHvncniIV6NqJq+k5UI8BsUENsOL9Q
 /lS3OIbs8eZ37aPaP98V2D+XDe84VjcIFN/fs1IMbh7ME/SIqKlmE47ehfJykzZWBeMU
 X0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792442049; x=1793046849;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9O0isZqxf9nkw1WQ4Y4OYTlaB7mcAfmGj74MlWzLwnU=;
 b=QMuE+tFXsRcXvW0oV33BJgCnYCLpHnm9fCQ1lsAvh6/LQugOVDkrBtNr02ZKyoDXCA
 xYvdOrjEo6q0lQubbv+dUtHu61ngmlZnkcPCcd9h6GzIbp+6cTJVtf8NDaQBaMfJcHVY
 mHcWu/Pi2dJzdyyzFMU1rS/WlKGyBwD/eRr1In6K3gQ/tndqlmfEJr2a/QH4TfP85ihy
 VjkVVy13jXtHvX16MUKz1L84fk4/dyWCj5QKQ3EhI0no4pWiNrz3KKwol+bPKSzsO+XT
 tsDZGV/ohOdvYOAVGJFYNB2mtwmUDE4+i/em4zfeygHfhuV+LY1sMBNHW0cA3Y4+cZDi
 qvIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKyhEi/9zCCdVyRHeAHV58wva0mz4aCLpzasSx8oV8q5po5H2fYrClMWCTmWgFWU5T29H/g2prKV87@nongnu.org
X-Gm-Message-State: AFq9FYL4nKXdbOgHKPIWfGYNjWkDGN4i+glahBqwOfn4sCYBjbIl9tLh
 GkmxEZE3Ps8sotXwPncF+qncFHApAKTv4R3WierGdYxJHAWFp65x5ZwnHnRcAUlFxR2jvkJdUL2
 0vkFn9bZNSafQGWkhGP7Iq1y9hNEgMOuuZhUs53zhf5nOnSWYGEFhmMwctA==
X-Gm-Gg: AYBFou0V5n92sq8696JtSmQqVMC9XfqatDirODwCET/XAHczInhHE6FNs+DEWxD7Xpu
 hDoH9f8R8U3tHySgY9KcT8BC1WzHrL5bxAivuWZBe3EuLRrYdhuRTXlgPzwBs6cQ0pQJZocw9Rg
 djv2rnNehDKh1qjJvEfw6xG0aPsUjNiMF039fwW/pUGXYKv3b4NtU1PJtBhlGu0ATKsWr1VXdpJ
 WaQzxs6zihpHYDZnyn4paNxcDky26xH9vbsqhp3v30hFZ5fE3Cfne4b+mCeJCOyolP8j9SiCE5p
 rWXlqy9qTXf4ik3/8n2k97TCdSkMRkYmqWrEUF2WhKCOBT9v5ploGdlNgz9I2bBVZitOq395Dds
 KAoqB59Vr/22Irotjrx18TBjhWAak17UOmY+DQSTNOboFIcf9Fbiq51G9NkV8EIMYQbObbw==
X-Received: by 2002:a05:701b:4510:10b0:144:fb87:5b91 with SMTP id
 a92af1059eb24-18513e80de6mr12078603c88.44.1792442048868; 
 Mon, 19 Oct 2026 13:34:08 -0700 (PDT)
X-Received: by 2002:a05:701b:4510:10b0:144:fb87:5b91 with SMTP id
 a92af1059eb24-18513e80de6mr12078555c88.44.1792442048005; 
 Mon, 19 Oct 2026 13:34:08 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831919fdfesm31248142c88.7.2026.10.19.13.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 13:34:07 -0700 (PDT)
Message-ID: <56244313-4c99-4a0f-946b-b75e54a8c1d7@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:34:06 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Remove deprecated '-name foo,debug-threads=...'
 option
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, devel@lists.libvirt.org,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
References: <20261018232917.7716-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261018232917.7716-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpEFe/O0 c=1 sm=1 tr=0 ts=6ad67ec1 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6zmBB6n6n2PSzIUxsucA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4MSBTYWx0ZWRfXyG3Wme1+oNpT
 o13b5hnHrOxoVvCiZNorO8RePQ0bclVdT2XHkuk+rJn4nAurbf2abigJf1cS/p+wxXgdjcCUTqy
 0HzUnmAZm+K3gdA/W7ubyZ38/b3p64iJUifKu5iyqYSbL5iljvy/Jxc6t4vPOlCW/v6PnKs0uvL
 wwW9ClT+b4Mz7g+fVvMr9rQTuHosyASP/RAHz/hcqc1EGSI0/d7rBE6l14jOZOwYFnjAlfwlCM7
 U1xBJ/kLENbGj7XMhYy9BU3wBizIun83tXnX9uZaOTLllTIPh7xY5ZWSeklRed+KQ5MkbeARvY0
 Ys8Tjj3pIXWHk01bDKYwKjyQnOLUTi/XNtS5+rSkFWwrGJPzQpvGwsxZxMCNLf73ycrk9mAJrkQ
 WMbtMrI6U0okA/JNnmCAn22Ek2pfvXA1hSnB+GoHFpNjFtb0ITAokkcwaBYvtZ8+wm2dJebUI2t
 f8/fbuTU52y0QTrpNhg==
X-Proofpoint-GUID: q82faaytoDvJJuiopfUAd84mfWkjdyvP
X-Proofpoint-ORIG-GUID: q82faaytoDvJJuiopfUAd84mfWkjdyvP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4MSBTYWx0ZWRfX5LkZbo6QEvKX
 C9ZvnQe6++JmeHBHhJqzZ8Mc59ep0Tm6UpJtANczyqwOhamvpUFK4yMkqlOyyitZHlhZXqOUtVD
 VmKngVOkp+GLtVRnTBTVM8YtqXKcizw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/18/2026 4:29 PM, Philippe Mathieu-Daudé wrote:
> 'debug-threads' option for -name was deprecated in v11.0
> (commit 1b65aeed2a0 "system: unconditionally enable thread
> naming") thus can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  docs/about/deprecated.rst             |  7 -------
>  docs/about/removed-features.rst       |  9 +++++++--
>  system/vl.c                           | 11 -----------
>  tests/qtest/migration/framework.c     |  4 ++--
>  tests/qtest/migration/precopy-tests.c |  2 +-
>  qemu-options.hx                       |  7 +++----
>  6 files changed, 13 insertions(+), 27 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

