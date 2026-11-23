Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD72606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fQ8oAzR6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FYURh710
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVYMY-0003dv-13; Mon, 23 Nov 2026 13:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYMV-0003dN-GT
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:01:55 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYMS-0005ME-VZ
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:01:55 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGmxa1861196
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CcmJO7pH1pFuFNxsk/FLjEAuy78lnNQBGuxMjAFJHqU=; b=fQ8oAzR61aYmQsb+
 UQV5fb+S5yarWa8kPSvh1ciwxYKd1C3ZZGsb3MRBKEaaX06X0zsCyHn+P+8Ed3hR
 Lbxmge8RiC85szDE44TahsNR8QX5lRU6d1OvketjGt/P4R5PsoDT6UkiIpnJ9xwb
 dJDcKBmMOcs5nwQ5kmZ7ZmQ6/OEkUdtLuaIjfhY5M1jJzk1Pp3cf9j2sqykG7WnY
 /M/Pm6fpXVmapNN4sgHbCutMhpsu89bUAHgh+4gW3oUe6M5cqa3bxZxg0SmThXLH
 k70mLulPhxNRGDtC25cMMPzIYOcS6z+pRkWxPF7eqw3dVa1uhjQcp6hz9/gMi1R3
 wFbHOw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g9a2pe9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:01:49 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b3b5b49cabso3231880c88.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795456909; x=1796061709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CcmJO7pH1pFuFNxsk/FLjEAuy78lnNQBGuxMjAFJHqU=;
 b=FYURh710eH3VKn58rwak1iVXYtzoWC9vUPnR90azxOqs6G4HKIdH52OYxbR3qNbLb5
 X94QH6htM5aqUgllweorgs2s2opXD1Ej2fbd34E0J9sOpaSGlONDaQgT9ee2pbTnuDh8
 yG3k84m6TusHoFR719gE9uhvDbrHV7qMVvnQuZ2CWpIwnaTkWhFevifAYukwd3RRlc2f
 7wzsGxpwhfmZCuFg/oR0M0sGalTy9caCtSFiwvL7LjvCiVNNjJe0fbo/fOTZBi75Hh0e
 gHsXHAGdqCFAnyRg/LO7+f0YogCqF0WTbIZYy41yYOi2U+xFUJj+qcwuVNkVGYYW36RR
 PVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456909; x=1796061709;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CcmJO7pH1pFuFNxsk/FLjEAuy78lnNQBGuxMjAFJHqU=;
 b=zVhZ5zvSgsqubv/81lXbgVQ1r8nqQtY7PeyEg4lMGEASRg1aRh9SHLAVxyu7XftjHA
 6/wQrHaHeTpB2CUzrlr5t/wHVzsbm+PC2+oeZfbKrN4G7acwl98YPYGReFQZeqU9jCWj
 6xF1gcyqnPi3kMa+9p2/vQZG07McbOgO24yNf+aGmN7/rhDTHQ/JaTV+pMlWaGFVbaH7
 +Ac6TOwxWMikl9CE6hZ/C/oOoFIDqX5ujfa8soKFsc06VIosnmByYIUDjqwyHeUN82f+
 jlhgE/NZRi3aj0efSRkDHqWOlW+yfpsAZ2X/kKQvrSnP7e8oFljFOsjQBcHTnLh/y7XI
 CIoA==
X-Forwarded-Encrypted: i=1;
 AL+hErFIj4YxUbXlD3lPksvb9NypYXteyksijFwm0vH//yRccrENgh4H4+ITfrUKcpDcSywemvQdxja5+/Hj@nongnu.org
X-Gm-Message-State: APuU4Z+9ygo8jH/i86QVgPN7iiw4dCES5Ry0sGz55+1Ns8s1Ve2Pkxc7
 5Cro4huqKNmeE97frm5983/8P443ZeIGPLjrzqmwUEwx94lrXmrRHYDfXiV3KWkhTBMzSWM2bOQ
 p3N8ujk0BFrmQWK20P4cqKM0vTk5SZZrw1jemkQCGV+kvnecQZ+7U9nX9YQ==
X-Gm-Gg: AZFdTZc7dIgl8K73Yh574iGk8FubCxN0ygWRcB6Hy7btI3clwK5GVdibHAM3O8AssfS
 FvPMsIHAxy59q26VbEwf4zIvb2AITKPaS5E4rbBcPVFC0bNFrD92n2lR+dFSjs8IFCIdtBRFO92
 zh00QJ8UixC0gtnH4BdzejDJUt4DBGrIigNbwNDat2NiHx9KahNrJnccHR2naEAVLSaloQ9L8oG
 9RdKQ6M7UCZXU6yFfapIuV/ld3as8GxZ3/oVCYX0JcJ5SGSQXCinAH5MdFvYAiDMAkuTZYblCk/
 dBXkkOdy8gEem9gWg2zxwIE+Wv8wCKl1bMwqba23y84MZwKBCpgiaETfvSRo2zIKAym48VIL2QC
 rX/S7+ULYBuTRCcnUEksK4wtLgAUao6nDx0btcvfbs9KThdPZfizXBEPD4rWsbBNAbc/gg6MJgc
 66b2/hwCCsrikPZOBIxQlb3l5CKzBVMueNvPKXFK/mRXk=
X-Received: by 2002:a05:701b:291b:b0:1b5:3878:a9d2 with SMTP id
 a92af1059eb24-1b5568e950amr10402520c88.20.1795456908976; 
 Mon, 23 Nov 2026 10:01:48 -0800 (PST)
X-Received: by 2002:a05:701b:291b:b0:1b5:3878:a9d2 with SMTP id
 a92af1059eb24-1b5568e950amr10402508c88.20.1795456908501; 
 Mon, 23 Nov 2026 10:01:48 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm30389961c88.12.2026.11.23.10.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 10:01:48 -0800 (PST)
Message-ID: <23dcbd96-6492-4226-921c-62f39066074a@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:01:46 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 05/12] target/hexagon: report the faulting
 packet for stack limit exceptions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120182031.560481-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX2jFXyMY+3aEp
 0013t6zhNOx90sYBoIv0Ugk7g4gDk3wRA67dNWA7H7cmdL05IxZOoO4L48ae20xFnr1HixD4P2y
 w2CvaAQPC7EP+d5XkVWkN4YuVdEk3Ac=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX2Qxujkvoyc3S
 t4Fs4SQWO5Epv+cQKezusa3U2BprstmdAX+IqlucDGGgvudXSZ+LzcQphfmg1aWsS3/uuHlYPLJ
 FdqABNwu6A7e2hKStN2ioiXR5ucJsl1JpC0Cxox0Ms2vavYsEypDbHnP9jABQr66RF+N0ny8VPq
 Gv0zj8PoBQDiK5XXdNn7uEC87TxP/jxG3/jY4stpQCjb3GwqBfW81MBXqyxMEGnoZ21Tsfz3FrI
 QSYVrro1XZqRQVlwr9kLCdrHAcphDvBnLkgXcFqhNsRlgtPnfURvkyYAPRcD3mkZUdNlpRb1yFY
 lOBXWc9z24hF77p1tPeKgq12BXOgqI6e3/b1nVGdZvj/HGjMfsH4GADsq3pqGlpk9T6ag2EsKwG
 TlLeQE3jhIvcXTMsqhTaESxh6uKeXs9nyCfGZ7dhFqRRQ03V1DwT390a0M/ObOXW7wySnh95DJE
 Qp23EJi/Qa6LpciyD6A==
X-Proofpoint-ORIG-GUID: MLvtLJXJpdiD4VEekXFiKDfI2ZlCYTSo
X-Authority-Analysis: v=2.4 cv=cYJHPXDM c=1 sm=1 tr=0 ts=6b047f8d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=mcuABler3LHUAgRv5qgA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: MLvtLJXJpdiD4VEekXFiKDfI2ZlCYTSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230071
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

On 11/20/2026 10:20 AM, Brian Cain wrote:
> The stack limit check raised the exception from a helper without
> updating the PC register, which is not kept current while a packet runs.
> The exception's ELR was whatever PC was last written, so a handler that
> skipped the faulting allocframe resumed at an earlier packet and took
> the same exception forever.  Pass the packet's PC to the helper.
> 
> This enables the framelimit systest.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/helper.h                   | 2 +-
>  target/hexagon/genptr.c                   | 3 ++-
>  target/hexagon/op_helper.c                | 4 +++-
>  tests/functional/hexagon/test_systests.py | 5 +++++
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

