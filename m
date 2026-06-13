Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43569CD98DC
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 17:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYSWW-0001Zz-D9; Sat, 13 Jun 2026 13:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSWU-0001ZX-Se
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:51:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSWT-0001Oj-82
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:51:58 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65DFAphd3283442
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=DPZ8Rdj/aNualg/exgRx39
 JnRnR+j66FFS+dq4fFEgY=; b=HrainCtgQDotbWTnLbxw/OEs4lNg+HjU/RyTZn
 fDpGddX+yAoYJa8iEWkcgLq7ErpnpDMuRRE5nwMKNkUGW+IvFlEYEVm3n7nBe/NK
 fHud4j8NiQst/O4defc6sDeqz1wrr+QTK8ELEPoR0LtfqjoNi6kkQ9zG/A0WUOGa
 4DRUnQEWrQmGQZ8PvOeagn7Qhf1lIY1TfCO2KT88FTwghDkGwUU92Cbg56LVEdTW
 3DjXN5Z1H0yozAc9tGbimSkbdaSoy+3zpN/afD0HRPo+dZ/qAD3d7OBuc27SNQQz
 HtB8Y2QVfGFb85wHwd98B8lLHpFwGwaXURAIvm3UbCiUcFRg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery8wsp8y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:51:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9156cb14b1cso91055785a.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781373114; x=1781977914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DPZ8Rdj/aNualg/exgRx39JnRnR+j66FFS+dq4fFEgY=;
 b=kcfDCeR7Qlhec3E92RJxNiNjUX18lMnkGbY2YwuJ2t9uVTTqapdy0Q0Xg9bPHjPTCv
 m778UWCDS0hipnq/SEbg8LzAdNI/UgXUeYdN8AavRIXZISI5kc1T0xaDYIdfGX3N6wUX
 O6HJE2YVoIfcJ1RVRhJ8XFvTIzv+hEqyudZo+l9bBx2bv1nImwyPG5eTr1wiHUd9qgYr
 mwgsHCsf5gNX0HaPFWQP4w8IWaJxCkzslkqLN4WllWaqmmnhZLKJpiDyCtlXLy4Jh74o
 BWf33BvhH+2EIQiJ1E9EAoSSbHgZWUVmRCooImF0eUt+m/BnLwgEyhN21AaiF7l1mmhK
 Ivew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781373114; x=1781977914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPZ8Rdj/aNualg/exgRx39JnRnR+j66FFS+dq4fFEgY=;
 b=Z6ufFDZ/Jo2mktwBTJTENQO3Yti8fe1degry+tvJvVB6k2hojPueWHugHslqOrOGaf
 Imsh6zzNiMA+2TVfsyCTTN/ehMzccfGTEFDQAbCOUJRb4dBpkHS2CFaO7sDAgCJ9LIQr
 SJ1yNDnbpJLv6mATd1dRs6gu+VAi5/fHHsqB2OVCWVWAooUCtPdrDfM9KPc4+ixvT6OW
 XNCizm7E7UiNqBAHxzWayBm5ip2MzlswTs22q5NL6McE8ZIGizqcSqgStnUzteWRr6PK
 vwxEzre7QFKByNkQuR/px8IgDZPMtg/TwZnnAz+NBw2auDMM+gZQB7LSiWEqoBCGc4uo
 As4Q==
X-Gm-Message-State: AOJu0YyJXrnvzPyehbx3xzu8EWvhkKo4SE6s31EQXRAPX8aZUDPArqVS
 Z+YLvJFBIUvOjNG1QnU1F3UAY5Exxb4oZ/+j+ghakr46hUemmLaELvsT8ENsQKbbpO4+I+axFGq
 DzpiakoEEMOGDAf1Lj6kYxlkx9Zf6QAmtyrfHIfyTDNMkRjaX2bSamZ5rYmVrQ6/1ig==
X-Gm-Gg: Acq92OHgWIhDnlLQZC7nlrFiEddN1T2snMNyPNzwDxjj2Nyg8Inhwt4D9FL65o/fjEB
 9yYKzSLlrsiehZjE3XJbBOWMn59JCRiHcn42Ti0mu+/6frOfBGWpis7Lf5wVO2BPkABIzq7lmGG
 RY/gLs8J7eMj7Vqt+iv7nm0SXplrYIhgGO/SPr7vXEIaBWsfWdOehqkcoHUnXIg5Sp8pKAivw8J
 0Gnccy3J5cmwWDZXjY4xStACBGKu4xu+5Em/elOU5V/SC82oT83iu8ZCcIsSOrTaRvuNK4UCQV0
 o4MtgewhUvndACURkgypI/8SxulM55EjEWz+bKVPYUrZpvpqYwPSFoyHZB6ZD4WSOqNLOXy7ZdI
 Zj7IF6+o9Lhx9Az1yEWcqh2DXwL93JDdGnVg8g5BUdiJouZ8Sb3/LAI6R9lmefPVEaZpRcao8VE
 knFq5Z5Stf
X-Received: by 2002:a05:620a:31a1:b0:914:d348:fd63 with SMTP id
 af79cd13be357-917f1865d50mr751744685a.50.1781373114003; 
 Sat, 13 Jun 2026 10:51:54 -0700 (PDT)
X-Received: by 2002:a05:620a:31a1:b0:914:d348:fd63 with SMTP id
 af79cd13be357-917f1865d50mr751741085a.50.1781373113537; 
 Sat, 13 Jun 2026 10:51:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f23fsm17139643f8f.9.2026.06.13.10.51.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 13 Jun 2026 10:51:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 0/2] misc: Remove pre-C99/C11 checks
Date: Sat, 13 Jun 2026 19:51:49 +0200
Message-ID: <20260613175151.1357-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5s1fSC-2B0JYMxXMFizSIZZjn8H-ABH4
X-Proofpoint-GUID: 5s1fSC-2B0JYMxXMFizSIZZjn8H-ABH4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDE4NiBTYWx0ZWRfX0e722FTkTv6C
 w00ctLiSpBmvnCXitAoQrL3HQ8Je/vf5Sdib8VhIlh+2ttcFfVOBiPb8oerS0sxTJIxLUpqfAVJ
 Ln9eduBzH5PLXdNQ0ITa41oNtdXezP8=
X-Authority-Analysis: v=2.4 cv=IqAutr/g c=1 sm=1 tr=0 ts=6a2d98ba cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=2Kr2Ceio6qlyrOmMFMIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDE4NiBTYWx0ZWRfX5JcYU9a9j6fv
 DWZHg8r7KU0U3K+d5KN4B2qxLGTExfIKP1dc2/3XILtLA1gTqdzg+yFMI9qkjK7ArTSC/JXzuai
 WsxLiwXW2MNsx6WNQJKq2Tfj3E1/RV24P5aL+WNKCfIY2lHtS7l33phKLO3IURjWkseGAkWG3nJ
 RMvEgSWvRsxtHjfVh/QiZ2xa8Tk/r/3m9GZ+VQzkjvULErNx90naSeNaRX8G6rgupc7LkIIgoXM
 lVMwvsDe0/0Sq9aPnKj2YG6CRyfKHKCeeFGTpjU7SwjWvqs/DdbKwe018Ee4wr5ubtuoLCFSJaL
 liG3mNFBYXaZ/9m8CWKGt2R0l1hoVlH1GvEVxy1/ZLbRwWNegWyQhgnjQ4hXsTY7uUU1b76UfV5
 quhHw4AOJNmcvm3IwCGlpsnTx7O1JkSX+fOuYqiMVz91nUkPmRKPRTkONQMfNjYGRvoRAFsK0j7
 oe5NFIS+wi2PmKqrg6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130186
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We uses C11 since 5 years now, time to
remove few obsolete __STDC_VERSION__ checks.

Philippe Mathieu-Daudé (2):
  hw/xen/interface: Remove pre-C99 checks
  qom/object: Remove pre-C11 check

 include/hw/xen/interface/physdev.h    |  2 +-
 include/hw/xen/interface/version.h    |  5 ++---
 include/hw/xen/interface/xen-compat.h |  2 --
 include/hw/xen/interface/xen.h        | 14 --------------
 qom/object.c                          | 14 +-------------
 5 files changed, 4 insertions(+), 33 deletions(-)

-- 
2.53.0


