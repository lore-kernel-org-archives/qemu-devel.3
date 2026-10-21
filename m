Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6D606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oB6whl5i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UBzXahvC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZCe-0005Go-Lf; Wed, 21 Oct 2026 12:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZCc-0005Ep-5j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:30:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJZCZ-00068R-9N
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:30:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LGB4Jv1083229
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LdH28CrUZ5te1hiUt16Qn3Jnjz80/AQwLDRmLnh3RZ8=; b=oB6whl5iOsNbTi8s
 2oK6+gHZnETweHp0L3IxgHzOv0LtJ6TinYtvziqqSPcjT16Z4fmaFQiZlrijdyQQ
 o8oFmspRxlM8P007TZCJX6zEeVp2HYNSfDm82lKGVXp2RVLtcYyBRz2xbbc4f5U7
 FK5FPC+VVNXFtgMbYan15gI54oeg/PmMjSdRdJh/nXfII/6CbZwGaOeJKo4zc4iW
 sID2vg3k5onmXkpCgvs457fyCEkbinLs5E/xcI5CfwwtLANJGKc6c6YBlpx8XbjB
 iPBK9dIeA50pZv07eSvkPU6sMDEKDhGA3fhrrIIwjJSHfbOv6C5uNvfxxcATtdZv
 heo2Ug==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r4286-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:30:05 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9907539aff7so781705241.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792600205; x=1793205005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LdH28CrUZ5te1hiUt16Qn3Jnjz80/AQwLDRmLnh3RZ8=;
 b=UBzXahvCNNXmZcC7qP4+HbMMhg4Rc1zMXecLNWSKyWUndd5/ihsR8ZzprVsS1NwWVg
 e2++DsPKY1NF+kmo6f+fGph9zTjBSgvfV5P3K+V1Pue6VJFI7xXjY10SPUVEHTzf777x
 sNv/4TOJPQcrBfXuaj1JrdE45KQAIojquKZ+hoGuSDDepFJOb3m03a5cEaQYBXdqLJZf
 BxtDhHX5D+AhMAKPXskNeszJi0cZIsxFdQAP78xls1pp4KK0rUYPkRLa5ABRULlumHAQ
 RrCBRb+zbndw96kccM0YlG+tzrqkX/A87B/B7zLG/hQjtUeHQVAo6FAEH6ZoJ0hq8ddm
 fpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792600205; x=1793205005;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LdH28CrUZ5te1hiUt16Qn3Jnjz80/AQwLDRmLnh3RZ8=;
 b=JtCw6yvvoe4M9s8xj2WL54mgJDLtV+/xUgjx1Tv80isi6u4GZTO6KQpW5IwtknucmB
 uRK5f9t/lEcxmWbHlWGPnDKp/CJu2aYgbCaqVNMaVWvsydwLihPlUOLjt/pfBWsvg+5d
 PdBQqxo6HsHPZlwnfzT2aDOEgbCpI8HVx2afA8dAO56Yw+DfWpOMzQ5K7G0MiINxlYNO
 OyXQdIFsQtsHKHNft8EtZ0zCUxfdMPA3QIl/uSn1U9oOhvSJVpomYX3/V8i267rYDlff
 4evrv/cVBLeQQF1Eqjbk2jZiUrr6bZRT/mmFhEzszjC5kVIlrH9OJES/np2GcFVqwdyz
 YsjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBycpvfAZQgUu3yLHXjMdJspTjNENXszw2WtqZeXnOGtiDuqNq+4GTzEr7DCTvMEsY0EtZ0f2a7O4Ldm@nongnu.org
X-Gm-Message-State: AFq9FYIzFbxI7v6X/dD4W+6aFy4vKYNklSwXpOkpqRPLOgHWgxeL4Bbw
 lkGSGHLHUHDZYj88nIHCPDZF9ingZBny3I4B2diVgSoct89MhSPUA2wjPq2/cf1D7EbI+6TsO6Q
 KsS+pBwqCPKN+XpDV6CEd9ddb2yThKCkqX+f4s4STc07cgjlykFGiODsqKw==
X-Gm-Gg: AYBFou0MgjEleiFTgYAVHRudF7EVgv26AwTtjNUT7Wibe8hNcMniVdxRrtajD/xZeQ3
 wt2SoJxxzbnKLglpVyOVVctrySqt7JG6cK4h1vfimhvVLHqUsyV0CKEZOcPTZocbog2vLQamJJA
 axaW39nrzh/7Z8KtxGPgV8CT5V1DF6AfjETm0B0EO4pq8k12c2rex9VRWcr9gmk8w53QPXczf/l
 7DClMoManCZqEUfQgEOje/AGqfiW1y2VYkHc+fnfo3CQueXZXdN8V/u/6UJK198O0eEjxca8v95
 mbrOPKnZawHhQ8p7NjH75WmeQ3QTrWtfekUaN8rOHQD6QQMUyeA4kaCwHNIu4OzqXanvwM3Z1ST
 z6D3AwSX58GrlUY/j0PeJjRx+YMoCUaRukHytlX0sXjk7RuAHsoJUTVxhPLSX+tmYKX0XIA==
X-Received: by 2002:a05:701b:424d:20b0:143:2982:1043 with SMTP id
 a92af1059eb24-190a7756a87mr3074952c88.36.1792599755048; 
 Wed, 21 Oct 2026 09:22:35 -0700 (PDT)
X-Received: by 2002:a05:701b:424d:20b0:143:2982:1043 with SMTP id
 a92af1059eb24-190a7756a87mr3074922c88.36.1792599754486; 
 Wed, 21 Oct 2026 09:22:34 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-190e29381d9sm5857122c88.18.2026.10.21.09.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 09:22:33 -0700 (PDT)
Message-ID: <5a7085b0-b146-403a-bebf-3cdad2bb470b@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:22:32 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/33] cpus: Add helper to log raised exceptions with
 '-d int'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
 <20261021031407.24862-3-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021031407.24862-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad8e88d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=893RUmfh5dJaGAfHNmcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: EHvnCaBXRzhe2ZUZvn1UL1RP5OZy7EpY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX9cQPzfsami2b
 MQPbDgw7mGt2o4FJKP5d36T1CLspJvD5z25s5m3J+NkB4LSF4E3mnlKxDP6zjQBOZVAHBPyr+lu
 eo4yEkSkduHDV9w0H9tRhE6AcaH5B8CPzs/iS7FzyuhEOLC++7FdNz6wSPXYTswzUi7VxJc8uCO
 xhVhauzQpcsYxTfs/+Pe2TMnYvrixn8zgdyMpitdHOGhJzK653E4hvcD9Oo032rUAiddJjL/NIF
 LMezt7ahDquRvhr+WIQ9vodB+HS32Mi93cJU7u2ezTS7P01XRog5+LmAulEX2F8gcbx9P7fGdN3
 gMiwF9zCv/uRP5f18b0+26Dvt0Dr6UR5WLBCsfQi8gL95jGKXFAXxjwgJO6w/gdJ0SlIdxEkUjo
 zufgVxRn1S4ZUwLrrf6Y4iWSuLlJ9nT2UmCNc6L8C8uh76XyeYcf+SIUNJcWH+STj0oa9CwAMT/
 FGg+YHJ3JCHdOF3b3ow==
X-Proofpoint-GUID: EHvnCaBXRzhe2ZUZvn1UL1RP5OZy7EpY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX1wCkh2fmdikz
 kctPAfHnr35BfiZEH8UsT7SV22otB7ymwPfFwD8oWgLPEesRJYdNzcNkP8KUOPDv/MJ7qI8WnTp
 dVUfnCdXkZacJSCIvgSja+Kui9Mry6o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 8:13 PM, Philippe Mathieu-Daudé wrote:
> Add log_raise_exception(), a common helper cpu_loop_*() can
> call to log a raised exception when '-d int' is used, and
> qemu_excp_name() to resolve QEMU-internal exceptions to names.
> 
> Use it in cpu_loop_exit_atomic() to log the EXCP_ATOMIC reason.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  accel/tcg/cpu-exec-common.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

