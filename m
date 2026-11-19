Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62F606E4D9
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eVMzjm7v;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fNXmaiGZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8Yh-0002te-Ff; Thu, 19 Nov 2026 15:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YU-0002p4-1m
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YP-0000rL-KX
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:24 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1DYV3594961
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UapivG8f51tWo3vDh6NSXxhp+g0QcNz6RdJgswsVvNg=; b=eVMzjm7vIDX4IkNd
 KcqkdBB+fbRZl7BHYFOMRfaGwI+pCXiI12VZUHsPXkxJ8xfyhGQA/6HGkOX90Xnv
 xRf+dRHRsb/0OpOi1SItnfrenTyRCAckS5ndVZGiTNCe22ubV6bOQd9zS42TEyzl
 hnLxYkrpbX7A1/4jWksBp3mkPy7H1qq/hmyG7uAgjSQrUMhbxMPXNcwGRkypHvul
 pPx8nQ+0PfMI3RX3LbeOF7uZ1tQXE61NcIWM2Tjo/Z9U5/FzcXDzXf50Y9GqGEDg
 uvezGqQoLJyAotug/Zl01alq6+Sohr3jUMq9HPt7Dm+ps4IZBB4eQHfsN8+SF4Fg
 OdVniQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j255wh13e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-375bac6bd21so101038eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119377; x=1795724177; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UapivG8f51tWo3vDh6NSXxhp+g0QcNz6RdJgswsVvNg=;
 b=fNXmaiGZoIIO6tm5NyZ+Y4kjOmG1pSDFfP0vZ6dZ5YNIbXo4QHXOEkn/OGe4Aw8iT7
 k9WBx6m/IojnEnh50kks9jPr2AE4nGDl0vYRPi4HI3N3cfoxIlMqgu7kyN+R5nbPsZFa
 lpalSZwfeNEwdHa/ROZ3GTM9V/UwA4kdhJw0SdnpUjIgDmrczfVCmTBb3yKalr6vBpN6
 FQuCoPl+kDfQHqecS5v9laWhQF0p+GsV/hje7lH76QdSfuh71yk8ewshwj+SkNU8+N2O
 tzmYb7z3kh70qZbM5PpPlugnKCCLQTDzWFvEPwrh5P2QNm2UfBeTqtmLbYRs3tAdeaBu
 gr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119377; x=1795724177;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UapivG8f51tWo3vDh6NSXxhp+g0QcNz6RdJgswsVvNg=;
 b=XT6nD+O4C3SZTqYWG9FDFGSEu4UW3lmyEE+Xsa+95r1fFahq6D5eq+CHu6cFns4mqS
 iDdBJ94AqAorXRveGiH65si5/C0PH710z4jNmB36GlwECEf9877xbGBY7QVoROhhmgBS
 2ukW293UwrwLEG6/y85LMd3tTUTgKOg5Md8d1ytNERaPOFjevZZmSEVek4qs0MXU6ZuG
 ouRWaWFjMkc+gQV5YHKDttwoZRa9ItGcTPCNET5RSseHtKWVSL2fIxIOjl/Z1TVIDqTI
 qeI/uSa4w+QSqCjRUvvNLOsR9NLI0q7Oj9IhcWKfJewnO76xf9UZiPRbDsCH3Odyjt8g
 8tUA==
X-Gm-Message-State: APuU4Z863eUIcCEJz4TRWfWFeilyl79D0oBW5pbJBYtDsjNACrOIT3B2
 a89yLJnUFKzxtmJMhocM6jXDkT8BJp1K9MOASWndWDyuatF53TQ98ZcNkdQ/EWtHTCmDIvpSOT1
 xBJgiwxC6kzRluqBq3qqymkxgRWPj5ZWRWEnY8/ff0hE33dfcfX/xYSlFNfZO7tpr7g==
X-Gm-Gg: AZFdTZcIoSxeqSQC6pkXMJA+hfrdQ0yD7pF60sPpVLXbNufY+Dg4m9R+1MuQ2/AIyYZ
 SoIXhl1ltdKxZWtqoIk25sEBQPY8ISsCqnnWQN5sQB7TWSbgV413CASC2bBB+3GMDPVp3Hbe98l
 jnBp/I6cT0ud6lDBwAaXoptTu6jDmggW+LlIUGSygUzlNaL7hcJLy6zFPsBn4/U+ECQ8/4K16JN
 ZHDEy7qtRuCYZncOQHHrT/54b5u8Shpdt1sjq3h7+Ugf7EOEYjTWK5vVymZURS4kwHTVBQAR94V
 Lnd1nxhzIaxG+aldiSg/T5tEarTj1J/+tUXbPyKB/fBATyrKBCNMzYbOSSjQWzzlKbVFUIQGdFO
 R/JhY1q2aehHDyKNC/Ri86Nbdz1gWU/NIOhdVFMmZ/T8ABRN3R25civo/uD2v5i4ylOtbWo77y0
 DHoMb/lx6deeBzg1/s8HLRKg==
X-Received: by 2002:a05:7301:2b5:b0:381:120a:c7e6 with SMTP id
 5a478bee46e88-384b4a80ec6mr1926962eec.26.1795119377466; 
 Thu, 19 Nov 2026 12:16:17 -0800 (PST)
X-Received: by 2002:a05:7301:2b5:b0:381:120a:c7e6 with SMTP id
 5a478bee46e88-384b4a80ec6mr1926932eec.26.1795119376994; 
 Thu, 19 Nov 2026 12:16:16 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:15 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-11.2 08/14] hw/hexagon: update the glob-reg vmstate ver
Date: Thu, 19 Nov 2026 12:15:57 -0800
Message-Id: <20261119201603.2377989-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX/oa5xfUYWhaJ
 YMRATuEgmrA4Blb4Vc9B9W99ZT/k0Dv1Tt29ZwONgaOv+ZYle8uKhtqeZpMOpd1M++mzWpxht76
 MChs50RNvfBhmdvHFFlsFpHpTjhzfio=
X-Proofpoint-GUID: fYEGqcFTk1oQ8eS4a-n1wH876WwIdp5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX53gxRi0GMTDu
 Gu5pHg1uLp5NvgThuWUzQvzCmmie/QKkFl5jaG3slW+rqjp9UQ6Rgw/TlTMMKvzloqIxo/wDPCi
 jibGV6Blm+ZgsXIJxBnLCKymm2ov9N4f31yEFb2Zf6WHESqWiRQbWA2nn0zGF23s/hWi67SIMsg
 gYbQTNNwXlkjM+W/ZvaDWkTjhiuvpsUCAqZBUZZWF6Za7uR8BBmlfpuIMJ7XPZnmJStHan2Hj1O
 HdFlxfnUzZ/X8CLikObmsmip9FhvR70eesHpO0YkT2F7ksHjeW7EuJnnYh4bwvNwqSfkE4WjarW
 wMUi9flktZ/g+NiOYZRhF9vn03ep3nmdJ/VDqSNySjEAB11QxmVrIvgqF/G+uQhEa5nVTbcW1sI
 XL1uh6s/1AlAmtPtdyHstfcUJQhS3ewWkHUmdrhNZ4I9iYz69Zw97lhxdwZ/pIFjpK2QJKo+JjJ
 AmZyAvyOCnlzV6YF+bw==
X-Authority-Analysis: v=2.4 cv=da0VTnXe c=1 sm=1 tr=0 ts=6aff5912 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=yPMIFQ6QiX0x8KKfrJsA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: fYEGqcFTk1oQ8eS4a-n1wH876WwIdp5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U2luY2UgMTEuMSB0aGUgbGF5b3V0IG9mIHRoZSBtaWdyYXRlZCBnbG9iYWwgcmVnaXN0ZXIgc3Rh
dGUgaGFzIGNoYW5nZWQuClNldmVyYWwgcmVncyB3ZXJlIGFkZGVkIHdoZW4gdGhlIHY4MSBpbnRl
cnJ1cHQvY29tbWl0L2N5Y2xlIGNvdW50IHVwZGF0ZS4KClJhaXNlIHRoZSB2ZXJzaW9uLCBhbmQg
dGhlIG1pbmltdW0gdmVyc2lvbiB0aGF0IGlzIGFjY2VwdGVkLgoKU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vaGV4
YWdvbl9nbG9iYWxyZWcuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFs
cmVnLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMKaW5kZXggOGI1MGZlYzc3MGEu
LmRkMzczZGVjOWZlIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMK
KysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jCkBAIC00NTAsOCArNDUwLDggQEAg
c3RhdGljIGludCBoZXhhZ29uX2dsb2JhbHJlZ19wb3N0X2xvYWQodm9pZCAqb3BhcXVlLAogCiBz
dGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGV4YWdvbl9nbG9iYWxyZWcg
PSB7CiAgICAgLm5hbWUgPSAiaGV4YWdvbl9nbG9iYWxyZWciLAotICAgIC52ZXJzaW9uX2lkID0g
MSwKLSAgICAubWluaW11bV92ZXJzaW9uX2lkID0gMSwKKyAgICAudmVyc2lvbl9pZCA9IDIsCisg
ICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDIsCiAgICAgLnByZV9zYXZlID0gaGV4YWdvbl9nbG9i
YWxyZWdfcHJlX3NhdmUsCiAgICAgLnBvc3RfbG9hZCA9IGhleGFnb25fZ2xvYmFscmVnX3Bvc3Rf
bG9hZCwKICAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKXsKLS0gCjIuMzQuMQoK

