Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC22606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p89pw3MY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DXpGriat
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xML9z-00056a-98; Thu, 29 Oct 2026 04:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xML9x-00056B-EG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:06:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xML9u-0005n7-OJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:06:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5Guj53829006
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AqNmHeOGd6o6i+DDKa8GQUdsD6jyiIRnn6B9s6cZbDg=; b=p89pw3MY9H+bHox/
 6NHNVHX9/9oV7nV7eoRy1079ZxyIr0GX6oilKRmsUYKAX4z1Sj3TkiRCq1xBYo+6
 mefVRvQfqXXu10sz85LB8kTLnwYs/v8Gj2wmnbyUO9ookQNC36dtrqHs4JfioFCo
 Ve+SlSicTv8axST0baz+bqrW9tY7hZ60+O3Jb8WZbCKFAX9UPuWAjADZXuAkf5wt
 b3ifJaUSbV7QMp1ebf/0tiDOmxsdz2uj5p88GmYCTO1mApPgWlUZBiaZ5FdcGg1l
 sTh7jYEIGV8/GqMdVH5pHOnQCjWGZS7r26QvfDe6pDDwtu6xlVBhM/BTzAkS9wzZ
 XcuG1g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hktmp9med-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:06:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5ab5c136so282119685a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793261208; x=1793866008; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AqNmHeOGd6o6i+DDKa8GQUdsD6jyiIRnn6B9s6cZbDg=;
 b=DXpGriat6xJu34w/8qPC8qe2pwsB2XsvI8EcWAQ58KrxeGysfMvLaYm8Kry1aJAZRk
 b+T6RmJVXXROHx08Uosi0TACnEjlDiQDL7whgVX4zfyrKZmGHyTg6m1yUsTW2LHam3UG
 Dt7CdEuLF/oDIV3OoAO0mJ0hw/kLeCK7bNu3qRuDLmvMR5phqwNzv+qzSzGk1s84lxZq
 3TbaKsxVammOIigEhl0emAcSB0xjuhSpsUApFX1itWonlIsRF8Jyd2jbY8Iw/sq1yztv
 0hfCEqFcKMFtVvJzHxmLOEhBmuzy+dJwhD5D/bT7iXR/4ohNHO7d1TdUu9g0Tl7uHoQ9
 40eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793261208; x=1793866008;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AqNmHeOGd6o6i+DDKa8GQUdsD6jyiIRnn6B9s6cZbDg=;
 b=H+xjz0pCXw8mfrI8EOeMeS90/17fjm/sA3OMPnN5otyfH810Y6GqtJycrsYeWV3CAZ
 l7nUHKLhoBq3ZLbX7FnKBHXi2OIkS45+QNIlJhb7j6ysHaBoEsBS22wuMfEEctbKHctU
 7cIt3I8SbdJQE7DL9fpB3/say4Hmx2nrg+rHGUjJ/gaaUTZnTSdtJP+a9fe7vJx9SE8L
 I3mcNLkVk8YfPRI1SbfvjI2w56vQ2l/4WMzDBwMMnyoK2WKKHgdSVwY66w+ey34XN3GJ
 1txfesvYETeA4QY5lwjbCK+1vbb28WWh4XOBFw8xiB7+JGrc1aSHjeWFTTvihk90T7OO
 fpTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzn7yZkryWv4p0PA8ZrEjp+VtSMqs/q444kdUHPKESC/fBDwRI356qNf6o/uJMaTCYbeqsJGYpLXqve@nongnu.org
X-Gm-Message-State: AFq9FYJ4cz/zpS5yV8UuwMkbPv1DCZ1chGurqoUZnXSXxXFuI4ss4c6b
 hcoCY0ohbYTRx6gtQVC0u8Qs/vL4QY1KLv0r7agHiyEiYDDSMynbNElAwiNCPG4mGAadgLyeW3i
 yhpuVYMTuZL4XcS0c/m+5c+e1KqKbydu342OTCcW+5rzJ+RMidRovi3qk3g==
X-Gm-Gg: AYBFou2plSktTCFTC0ICVef10o+9geS5gRCK34Hua1aj3xQWa/SanKlRvJZz4qVlsmC
 vS5RqndBSs121X2jGhp0pYAJ2nELMFQu+qPaLzi7iEZchHRGNcfWPWxJ+B3tNGaAZ6qb+Ao+gkS
 NmGBBz9hrCKpoEtD3nVXYb73tXWISGInqkUPN53Ph3WklKCF145M/J5Z+duIQIdZTe2MFXD8TjD
 pGvntwJp6vPr8O2doZro9yZ5GwZI5SAnnTexC+daNs/7jjLY2Q3UygwORUSGNO5Y4+zo9POrV7X
 wIGNS94DRiC/tzsc5Bbn6C2KXKhnOEloloY7I16C9+7Y7pjArpaKB+HJXeKuJnKlZ5GYDXhGz7W
 BkALFIvu03jnP0vtk4EVEQWMYZ14qzuadj0YT81wuMpBr/TKjqkRg7gjpolme+BoHd+Up0GIL1X
 MewoInVgJsCNyjL6f/RihyvXk=
X-Received: by 2002:a05:620a:4111:b0:93f:5cc0:5978 with SMTP id
 af79cd13be357-94408cfee99mr696532585a.37.1793261207769; 
 Thu, 29 Oct 2026 01:06:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4111:b0:93f:5cc0:5978 with SMTP id
 af79cd13be357-94408cfee99mr696528685a.37.1793261207175; 
 Thu, 29 Oct 2026 01:06:47 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dd7sm33141145f8f.15.2026.10.29.01.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 01:06:46 -0700 (PDT)
Message-ID: <de5dd85c-e486-40b3-a0ce-613cc102089d@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:06:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Sashiko
Content-Language: en-US
To: Alistair <alistair@alistair23.me>, qemu-devel@nongnu.org
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
In-Reply-To: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfX3F/LQxxxqmwo
 gzQhq/9XjOQ2/upG22NEGSdzp+a+1EuZTbcVHDlF1twqJG1U7yFyiFRCcoLVKUPSW58oYe2mhKo
 rUp+HCMq6WBOqhmjitzuUfORQRS1rt3gvpoF94EttdqJg1rj0FNsoV/ualwngFbYJxFnepsL/fI
 xtqwVia1pwKvsyTO6IYViZ4z5cAvWXAMxCFVdJdcTc1hQ1OXnkp/iLqWsnSmrog0cyqzVwvBxb6
 0uyYXO0LsT3ytJsUbKnvVSw68esOZzVzQmhwLM+k10PVctO4HFmnYJKY/aph1VHgHgC9WxOHxqf
 9ZvM4OEVrytTHr3DAopsC3BuFJ1RRZ2W61s+xBilBiO4MHwdWrGBy9G6xq+8aOSClFHs7HTvszk
 OecqsHzPpNlo8ES+fjsKitxoQSNuIPxmnYOALqlsmGnyIoN/LD7PXmq+Dk6q0Mbpr3J8+BuE9F6
 YMArrI4dQ47djpm0Hqg==
X-Authority-Analysis: v=2.4 cv=crYOAF4i c=1 sm=1 tr=0 ts=6ae2fe98 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=F15X_yQonrbWqZ1-Bc0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzMSBTYWx0ZWRfX/Nt4uIdM7uuG
 0fMiTccmprqs+wzDNRv9ZwoW7rrlx6mBAlXm+gOIOi83iPdB5GX4oRKMRgoox+btywo+5EqpOZ3
 imzANXItT8nSy8RDOg6nPLEXEf/eIfw=
X-Proofpoint-GUID: APJO3FixjWWfSyFkCDsWhHT_r41ql_iX
X-Proofpoint-ORIG-GUID: APJO3FixjWWfSyFkCDsWhHT_r41ql_iX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 00:32, Alistair wrote:
> Hey,
> 
> Sashiko just merged initial support for QEMU [1].
> 
> For those who don't know, Sashiko is a LLM powered review bot used for
> the Linux kernel. When people send patches to LKML Sashiko reviews the
> patches and responds to the mailing list with any issue that it finds.
> 
> Like all LLM tools, it is both useful, but also verbose, prone to
> hallucinations and misses things (like humans do to though). The
> general consensus in the kernel community is that it's a useful and
> valuable tool.
> 
> Sashiko is just a Rust application and prompts, it doesn't include a
> LLM and you can use a range of different LLM backends.
> 
> Google sponsors the development and runs a Linux instance. So you can
> see the hosted Linux instance here: https://sashiko.dev/ and it uses
> Gemini for the LLM which Google pays for. It seems like there is also a
> GCC one starting up.
> 
> The cool thing about Sashiko though is you can run it locally as well,
> so you can use it to test your patches before sending them to LKML, as
> long as you have a LLM backend you can use.
> 
> So, now that Sashiko also supports QEMU there are two exciting use
> cases:
> 
> 1. Developers can run it locally to review their patches before sending
> them to the list. This can catch issues before sending patches
> 
> 2. Maintainers can run an instance to review patches. How you set this
> up depends on the maintainer and how many tokens you have. Pointing it
> at the list directly and running it for all patches might be too much,
> but some combination of manually triggering it for certain patches
> seems to work well. The Settings.toml file can be setup based on what
> you want to do.
> 
> The hope with this is to save maintainers time as Sashiko can catch
> issues without requiring much time from a maintainer.
> 
> QEMU support in Sashiko is very new, so it will take some tweaking to
> improve things, but it is at least a good starting place.
> 
> 1:
> https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d4517385916e6c834d8176f70

I'm glad you added projects/qemu/ directory there; some time ago
Zhao and myself tried to leverage LLM to review QEMU and reduce
maintenance burden but there was little community interest and
some negative feedback so we didn't pursued on the list.
https://lore.kernel.org/qemu-devel/afxbDjQEWJZ6P9oe@redhat.com/
https://lore.kernel.org/qemu-devel/arpINtziWCbjENeo@intel.com/


