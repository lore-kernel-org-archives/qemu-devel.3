Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201F5CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUGm-0001cs-7i; Fri, 22 May 2026 14:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUGi-0001bk-4O
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:06:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQUGb-0007Mi-7A
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:06:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MC4ca41959117
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lN/uEBH171tqhWqwGydl5ToC4Om0Yr6MWuw1juoy+Gg=; b=Akiw9ERK70bniM/7
 Ob/DLooWc0QrU3ghm6BGUWe0hX3svm3k9Jj1dYF4Y9BHPM3q9Sv78NBkLEXjJeAG
 PWsHTwhlNpMfsQEIbfpB34gP/6WQ8bFeTZEeIjWVbNGORb1fMnx5xHNqOmhcmVP5
 s4a84861AxgdlWUWUInAAMs/4uFmCPvNdAjV9nQj8R8SCCRDSa4Vu/5UMWR0Xqh6
 +4hlt04Dgb4t6E/QAaUHiNSmDhElDGHMrC6agUYvmj9vEq6dzdlRS1X0LA21KnwR
 9tdGW2jg5o1rd/l4KwFuTJye2KtYzDuZ5sz96aswWr962PtFjjZ507KlQL2iYKwe
 3d7Yqw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxetsep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:06:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2efc342ef15so9425035eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779473193; x=1780077993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lN/uEBH171tqhWqwGydl5ToC4Om0Yr6MWuw1juoy+Gg=;
 b=PSmmqSOET0viadIqMX23+V6y1OyzbliM/zGrF+6kg2nSMEAQI/rUwvosMnb4oYMObJ
 LbngOEsgk67qo6gCij9rrDQ0n7D/CDkY9vC22gS66x7aYH4Md5AHSxrLT5+pUHmzeTde
 5sMI9boj2PCBKSYKtB4OR4Uq8yhludbc7rl0eZWBEL+IYR8R6Jc081pfFGDaqk7sMOPF
 PfjhvwU8slW9S+/9S31tQ77uhCDdCKIw8IEocXyoVhvstfd8YNXVAftRD5CZuprV0MbJ
 cGtj0Nq4fqaq/4MLmzXGr62kDd89o/Qs8TDwY93AGyIVuw96uYyxPbH1kPt81GVxiAJO
 yLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779473193; x=1780077993;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lN/uEBH171tqhWqwGydl5ToC4Om0Yr6MWuw1juoy+Gg=;
 b=rk9GsKcjPt4nLQrRI+TFK3fQabFG6Wu/rbsx6qiN5QHfcNouzmqqDpROWQ0sLvwxFz
 7ECQ1CU8CPekVtcJppdf5DEr/ho7T01KHYmg6jdc1Zp1wRQd7EgUDBx983dy7cLN3JZb
 gNoqbns1JKawJjkR1qHugV/v4/TR3JkoGl2aKl04ugYhn56c32FbNyjH3N9yP2A3tTZX
 r3XZca7d6WV2YY34IzZSeylTvAhegzcqPRtYPaK39j8pXmywZLFjzCBiglvihZzJVahj
 oYgh+kXZo9UTpJk/W74VoSFRiNnuBy3yr9Tg+faUK4M8o+7Ei1OImra7m/+BYQXcHkfI
 GJwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ94/roaNxgIZawVURR37rDw/a5CvVM3xigNdSF53bu4nRenwZVQolEPmLDL+HuDNZ5ApdxRMV0BTi9a@nongnu.org
X-Gm-Message-State: AOJu0YyaxJQmVFOhpD/b8O4KX0FqH8pT6cUBEZd+br0K/WKbrXd/GQfx
 NAMdjldZVvXIuJoTg0rCAjZDurENbK1583fQXaG+qr1NBT4mpTMpQLnZx6frEyhlXHHxVBsMToA
 qD8HVtxqAtTk8Xzq+r/BnU6UeTmNWyHyGKm5/yoR+/xNHN8cYRdRz9BqinQ==
X-Gm-Gg: Acq92OF2s12pXuKdzXgjSgjRYPAKh8LMVf9PFOSDI8G0/HkHmz6VJ7XHsWvLGQRKCEV
 ttTkmSUbRmh1MTyFXbBXT4kN9CRppUVo4iSD+KTJAiXR7VQozJ6hpNwaoiY6WjqjOCuU48JM/lT
 dHx01pIqyOIufCNDKQqaAjqNiViHDtRZ5eh7fzBd5uXDxNii10xGRyRcL4DURZjWENHMm+KaQ7F
 mqLynJlZg3+JhYTKt/hzA3ejJEKirWyYX30Kvy0DtGeinyOKDdaWIvJmZvFoKgOrsDk8HC5BaVp
 2hYjeCbkzC3wBQyTA6NdkLptEJe290jE+6K1r8lgT+Uka61L04NagACbGZODgbnw9eMCr2NuDhU
 N0k9NwdS526UUo2cB3qCKI4FuvHZb9mS+WXV645fPYc0FZ1olArCXABGRLd+0WwvAc70AdKXw17
 N4B/dXbiIOzTVs6g==
X-Received: by 2002:a05:693c:63d1:b0:2f3:986d:2d01 with SMTP id
 5a478bee46e88-304490543damr1372830eec.19.1779473192698; 
 Fri, 22 May 2026 11:06:32 -0700 (PDT)
X-Received: by 2002:a05:693c:63d1:b0:2f3:986d:2d01 with SMTP id
 5a478bee46e88-304490543damr1372819eec.19.1779473192108; 
 Fri, 22 May 2026 11:06:32 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4719sm1510055eec.1.2026.05.22.11.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 11:06:31 -0700 (PDT)
Message-ID: <ac1d3401-e4d1-4113-89de-13dc7ad36a91@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:06:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/qom: Fix some editing errors
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260520-qom-v1-1-baad87fefe4f@9elements.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260520-qom-v1-1-baad87fefe4f@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MCBTYWx0ZWRfX7xkflhLC/E//
 l/dQS5YgHBaKzHxgFwBTnMJk8KuGcMmwcPUq1skG+v5oZ8HXdpBSpCk7NNMC6cNP1Q3uT85zXU1
 rlJjyRd/0NoTVkkvbHCKd4RujOVFEcj4aCUSMuBOkA5P6Vi3LqnR+KwYgMc0qWBMczGzKBLg+VM
 b++K3W/wH4MFnQmWMQFPSph65aLEOxRDBAB/96NTMTmGqCnRZiA1rasjpAs4vQcGSK2oqq1eSBX
 hAbyEN3Vv+/Exl9GzxX1HSaQN5QOKdpEp7pCFzigc5wFd8N91/hOH5cAzBPkZM+YTQjNgqIjUAf
 Dj2MFTfAWwRRV49OFJprjYqyK5Lb8ep0t2ML8acsX5SW+tYT7q1kVfFOYdpxH05I1rlGTQLir2C
 qvv9eoeeYbkh6kJZAvQG5LamDq+omoiobj1t/A1Q7XdBKBDF6a62TMNIZT2TqHuIH5PGlh8t/v0
 Omo2/G7uQ8ks08p6TVQ==
X-Proofpoint-GUID: SjKAkZvPnsQSP1f-wE1WT6dD33MTqUXk
X-Proofpoint-ORIG-GUID: SjKAkZvPnsQSP1f-wE1WT6dD33MTqUXk
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a109b29 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=PzGKxP3WAAAA:8 a=EUspDBNiAAAA:8 a=OAh471V0lmrSu9h-Zb0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220180
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/20/2026 4:15 AM, J. Neuschäfer wrote:
> "devices have an two additional [...]" -> "devices have two additional",
> and also a case of "were" vs. "where".
> 
> Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
> ---
>  docs/devel/qom.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> index 5870745ba27b108726da0756aa2b90109d5e0bd6..935bb1004a7839c8e963985e765c866d5b980c53 100644
> --- a/docs/devel/qom.rst
> +++ b/docs/devel/qom.rst
> @@ -435,14 +435,14 @@ OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
>  Device Life-cycle
>  =================
>  
> -As class initialisation cannot fail devices have an two additional
> +As class initialisation cannot fail, devices have two additional
>  methods to handle the creation of dynamic devices. The ``realize``
>  function is called with ``Error **`` pointer which should be set if
>  the device cannot complete its setup. Otherwise on successful
>  completion of the ``realize`` method the device object is added to the
>  QOM tree and made visible to the guest.
>  
> -The reverse function is ``unrealize`` and should be were clean-up
> +The reverse function is ``unrealize`` and should be where clean-up
>  code lives to tidy up after the system is done with the device.
>  
>  All devices can be instantiated by C code, however only some can
> 
> ---
> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
> change-id: 20260520-qom-76537da673b6
> 
> Best regards,

Thanks,
I'll pull this through docs subsystem.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

