Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C4BCD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVFz4-0006rd-0r; Thu, 04 Jun 2026 17:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFyz-0006rE-NW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFyx-0006hw-Qs
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654Jnxuk3111650
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 21:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1LWTODSuTM4B3+NBsbybvQ
 SFvvYI3EIkV0DkZWbRcU8=; b=jSbXZJoSLfMNcF6BEguKHyA2qFB5sZWtACJj39
 Ar64dOgqth8+sOhbvPdY8sORKQIpbBdtdBeBX8G7Au+X29jQsWwX1R2LO7eSjHj9
 qABr6UkuGxafzc516srY2WPi3zqBRcz89z9qrTvG0r+vCkuLosvn7AEIEKd1aGCV
 XLKwnDx1QOD27kJ3f7uPJ2DP5Y0tJ4JZ9vzlvPTyv42nfLi5AgT2bbXz79b3nyz3
 G2xGKdqq8RHHGadhCVqfFCxQTA9d0WeYET9423TbNtKuy/u3DTSyrtyh8V1EYClw
 eauYbOm9GayAev8A5bp9HHXnUxz4TytFrOejTURaYS/tNcDw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekfv70dsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 21:52:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304d8613efbso1126139eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780609923; x=1781214723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1LWTODSuTM4B3+NBsbybvQSFvvYI3EIkV0DkZWbRcU8=;
 b=DvqW/ol0/PNTfybtR2FeNrv3lpk87WF0QxSX2mKaARbj8EzI4Hhz+6q/yDOeqaIR/i
 COf0Lc+JKGA/7gPCEmBF+AiV7khHYhr1zKIpuU+ETO68AB4R7gkpadWkkykx/KhG4xSy
 7QDS8IICrE2oPUkCmxLhITiR6+jNzeruG0izkbWtfKLFvBkMovfFW/7ME6M1dhGEWa31
 1jlUAyz//3kLJcsZjHGeY1jO/HEnYKigOKNwlar67Mxta4P+MHX7tHvL53w0O8CYKZ1X
 xpegDTBAlDYCWyltmV7xgexYpCGnFFm7bc2uR47BRfnHND1BH3lv6hjZMzDP7890sI35
 0FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780609923; x=1781214723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LWTODSuTM4B3+NBsbybvQSFvvYI3EIkV0DkZWbRcU8=;
 b=kA51nY9Ulf1uKWsgE7zm4q1PX8KEEUQxCylIhDQ1s/IKD+tNucOB8CiH0I1kk8peXa
 0z1AEt5fShPazlleh9TNhCnAIDBCqk0F8bGddkPpQwmQdtjuXvKTdvJfZJevdTu0Zuxw
 y4Z1g+aHtAZjL2cyN7v5TDOnlO3SNEyyq395B2wQrkb4YIU2soWuI8ZNobmjGOTPx6HP
 Wk/zONW7p5Fof6j1H5xRN0+eeHFQJLmdn1noHJMPQ4EjTni9uVDWYHyLEbnmEQh8em6a
 PKDvZqMMPKhnOEcXJfyDovRc9UnBur74GdFMIh7V707XIk7DWCU0S9s6V3AE7cFYLWaR
 3JIA==
X-Gm-Message-State: AOJu0YynC+/XQM6XRhtPdE7dQBjgUsfolrdj2HcYX7lWeMwTmSolJ8JV
 D/FmFeJodq8TBGeNm1zBCtyQVwLNuJ5YUWyIgwvB7pzKfxSxKGSYDxW08eyofieqyBDpiUQPPj5
 N4lg5Uag5HcPzPeKrXMz0YubHkdExgai0O3hCZTs/N27E07W4Jbma7JXEZQm0ApbsHBt3
X-Gm-Gg: Acq92OE7Rdrm9RWeAni/fxb56LB0TCUMyOP4WeUs2fSxDV+QFDwWqV9ZF+Hl0tuKoi2
 FdvbUFQTOJbPGkJENVqJvu4BxQVlVPBrqwxUH36yfW6zhqMl3YqpaUCVrTMQOs0xenjLgzu7Y3G
 p3ClyFQ8IAyA45fe85bfc4JKWJuS60bL3uEq2g6OiEXuwsiRHtFag93ttUpO68UN+YzJAOvVidZ
 E+d7koO+5OlpoM3X6seeLc6ieZVzlbFNUS5drB7Lnj/C6Si2Bz3b/m9ReeNRteTmQ9S6UhMyOdi
 yFuJXQusaMed+YZq9KtVtFduVAlmCOA9R1HvUgmjOvv3F3C8I/wesxqSC3bJmnP5kFD7rmiHE+U
 4zKecnrMhI/VtW/fPMtn9xiNJLG7rPT3EpCcZZHsrBcqA2k8hC2AxiAyMJIZmzA+MfpF3EM+FiR
 BvoSa2I5ncW265L8YI
X-Received: by 2002:a05:7300:214f:b0:303:f2dc:8ab4 with SMTP id
 5a478bee46e88-3077b32a447mr299915eec.2.1780609923337; 
 Thu, 04 Jun 2026 14:52:03 -0700 (PDT)
X-Received: by 2002:a05:7300:214f:b0:303:f2dc:8ab4 with SMTP id
 5a478bee46e88-3077b32a447mr299892eec.2.1780609922789; 
 Thu, 04 Jun 2026 14:52:02 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df64eb9sm5270115eec.25.2026.06.04.14.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 14:52:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/5] gests: update ubuntu2204 to ubuntu2404
Date: Thu,  4 Jun 2026 14:51:42 -0700
Message-ID: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: A2rHdibkZmTPJe0TypKNClQbTfTiXOUS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIxNCBTYWx0ZWRfX383s1MyV+uPN
 GJYF5GoWyN4nfsnyUgizgVa/P1JbgMA3yiC4CT68j/jazttXZaFnxGc0ddlxQDE+rbA5NKMzAuK
 PTZbPybABmr12hdfAPawOIA0h4bsEN6I+4NFpCuB9i3dDQM9SrYMDBRP8sHbzLytrkklHi69Mfa
 6Z6/Hw/BG/4ZvR/MSPStqaa/Aw+dRlXmyN+uMBMGszG30Ufg1+BWOnR7HHf5UFpN0DuQXR66a35
 OVa6KqcpiitJLol7/JE8n9m7twXJTB2AUA8mAgtmzGujtBtNpPoz/kTmfE+o8tAXu8r/3IbzRXy
 JSs6PjlZGsG3Nl4kkgSZ2WaxfpeqrQt7quch4C3pGQKj0DfW6RdJzoX03UOGG7FDFykqYZ+7SEl
 u7r4bp7ZJ6CxyGsixAq5rs1c+ldESziLBd3zJM/4rpKBORR1y5vYj1l4oeC6YlckVLPAl1tBWHz
 pEnMp91zyWX+rxTScQw==
X-Authority-Analysis: v=2.4 cv=JNULdcKb c=1 sm=1 tr=0 ts=6a21f384 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=qqeRjDhJmekrPX468NMA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: A2rHdibkZmTPJe0TypKNClQbTfTiXOUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040214
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ubuntu 26.04 LTS is now available since April 2026.
If I followed correctly, we support latest two LTS releases, so we should be
able to update. If not, feel free to correct me :).

Pierrick Bouvier (5):
  net/af-xdp.c: maybe-uninitialized warning with gcov build on
    ubuntu2404
  tests: add ubuntu 2404
  docs: update mention to ubuntu2204
  ci: update to ubuntu2404
  tests: remove ubuntu2204 container

 .gitlab-ci.d/buildtest.yml                       | 16 ++++++++--------
 .gitlab-ci.d/containers.yml                      |  6 +++---
 docs/devel/testing/main.rst                      |  4 ++--
 net/af-xdp.c                                     |  2 +-
 .../{ubuntu2204.docker => ubuntu2404.docker}     | 12 ++++++++----
 tests/lcitool/refresh                            |  8 +++-----
 6 files changed, 25 insertions(+), 23 deletions(-)
 rename tests/docker/dockerfiles/{ubuntu2204.docker => ubuntu2404.docker} (95%)

-- 
2.43.0


