Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409D606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X6bH6sKf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MOaYhWpy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT0Xn-0000zT-Tk; Mon, 16 Nov 2026 12:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xT0Xk-0000ya-OS
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:31:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xT0Xi-00055z-6n
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:31:00 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGIecm2055783
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 17:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=CmBRC/fE7JFMfAKE7aGgk4lXeph89E/sfNS
 gf5Z/xAI=; b=X6bH6sKfD34dPyHH1QdnX2jA+qCfp30U3rHNEn26r7kkLHH6Tps
 SShb/oXs/L6CbOa+2VCHUy2z/Ufqo08VzX3jxhHXwMahUSosKgXMP4o2PqtKfX8Z
 eDRyny5lk6IJnMFc2P680tjPu/5Md+iEekf2z2TtahA9/LzudC1ep8yasDRwCdhj
 zKCraEmrzhT4T7kTys74HxzaBP2fAsZr914Q3imkm+JEbKdDyO1Me/mq4JFfx8PD
 8P5wHyYjB8S7CqYI1/xA+S5t1s5AzC1AeqyzUf97SaZaWhea/DvLzWVgiNK3dKK1
 kMBh7hjiHLycMiZYC6/Uxty6jwVtEDuAdWw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqhpq5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 17:30:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-55ba5fccc4aso48025921cf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794850253; x=1795455053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CmBRC/fE7JFMfAKE7aGgk4lXeph89E/sfNSgf5Z/xAI=;
 b=MOaYhWpyegxOE0gchm5/LivvP7zmT7F2mvCFQF05KsT+ee6h/aTQfRktnmiupfCsrr
 BFI539lsh/nZ14xzM+E5BSDe+DWVYTzv58IE4e5VTSgTeXCIrX9+isqBkHn5XmBVYBUS
 Iqew4ERGqsi1bqqvGx0MrjubmiNm2Z31oyKfbP8L4DG/lWmejv1QZxq1wrWPUdVI8c5p
 nlHXAynI69EYhHkP3TM90X+qc9NDZjXVmOdDceKKp4d/taucb5bXhBZJO344o/XJed0a
 dWQ8/cMt924a178bmaZ651kk7v7jQPEqgyINKtgiPjhrWZIF6buNtM91/15CMU0Z5vgw
 XnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850253; x=1795455053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CmBRC/fE7JFMfAKE7aGgk4lXeph89E/sfNSgf5Z/xAI=;
 b=XeqmoqTCYI5LPjWnViYjDlkefiWbhxTCUWlIePWwnmrPY7iUmnmLFSF4I09laa1u6D
 5cKhXhiVtI1CcSznEl7UrEGehu7HIwkuXArBctDF+ZuBBODOK9+clHG8Pw5YUll+DkU/
 agjwR+VheSi8fIeIUgczO3uki0GD4Zjy1G2AL2bS5ZLlLf22GU/Mi1vIWdIbmrL4hBWc
 3iPRXgZeCIJx08lusbHC/YQiY5E9Av3vowzlhAUcWKf5qjwL2nKjG/n3GS+o1o2q831n
 IAjJleVZguxSJi2wKXcW9MvpyzxOrpZ7YtGYn8QrnZ0ajnpJWYTtaNjgZHzmbh1w7DAf
 o37w==
X-Gm-Message-State: APuU4Z+GJTByEGyQvVemhs7cDwLzv7A4aBnXoDqxtyr950nJQHuTEdNA
 pV08AhKe8IiqqEOTPj8BkREI7HazO1xaQLIaZ5ssOvYFHe7sd40DKEa2rcAf06reNsbCEZgoGDL
 q0eGRZmyykvzdFv8UuwD2mIPT8T69ldbvCysVVBDONvJizvK7VGs2J9g/9AicEFOAXg==
X-Gm-Gg: AYBFou0ijwwUdG926IG3lnUGjLchSAquGup6DpwpppGHw22GAfz2P+lVWxIVpCS2Iw9
 LqNc/qAuZgsT02NhJDBbD1DpOmEkeZ7ixiseZWDIh3GnTg+bibNFKXZ82ut+AoPOnApWGKwmBGM
 jgO7slpUAY5awkGkb68V7S62NYnNWnPSNhMNGEjwrooKrV3qlbqOa7C++WfxS52zD9KwandPffW
 fwxaO0DlDKj0VFkf2KsEHqTV8f8g8yhx9xiEstJBA8hYjcgHH/R/xFFxGj69FS4ZY+gAwiAj7Bz
 xT/4g9pNUbClSoz7l7y5evLFq5xpiW5DZ4AsXcGqb06ILS7hGfKm17mU09FrKi4GicYyNZkBM3W
 d1cRKs5weFm3q2Ns82zCt3CwIPaQqfbnlM+F2bQdHd1GcPk0297TLbXvC0Avu1KSU8LkrmW2JH6
 ruktfATf/Q3HY=
X-Received: by 2002:a05:622a:2585:b0:536:7220:1d37 with SMTP id
 d75a77b69052e-55ac888aa66mr176912241cf.55.1794850253206; 
 Mon, 16 Nov 2026 09:30:53 -0800 (PST)
X-Received: by 2002:a05:622a:2585:b0:536:7220:1d37 with SMTP id
 d75a77b69052e-55ac888aa66mr176911561cf.55.1794850252575; 
 Mon, 16 Nov 2026 09:30:52 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8b5c1dsm898530385a.33.2026.11.16.09.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:30:52 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 0/3] target/riscv: mseccfg CSR fixes [GL4680,GL4818]
Date: Mon, 16 Nov 2026 14:30:44 -0300
Message-ID: <20261116173047.812886-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afb3dce cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=WERq1Tg1Nl5IKGfG0e6imA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=4mDEp5eNMeDgTd3wHUwA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: KFWOMxkidAqr7OWW2GkQZ-2S45vxDgPT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX9cu2zuItXner
 Vx87WtnqJ45jrvgCEzDEMHzduGCz5j0Br2glCPf8iTow43tokQwGC4NKGZFOz8HYa5PKM+EYgK4
 CmSUSX31sgYF6RsecF8P/TY1/DTgAdnLgYfUN5EqnbqeXt0OZa8gdTF+16maZ8xIK+ecAXhqHzl
 ZTlrMKlhFjKfn0ZsMDKDwSuC8BhASF7PSpv8fOYDDdavnPiLj0PHlnQ2KLoqD+K0unqTt3XkWXz
 X6iaajJlFAkAfQbLFHn3mYoUQnV8wIsNcPxsMSWHBX5yIWb0Vqdw3bCiAkFXAXYjKrFUG+DRYGF
 0M8dDUb03bRmEGQcfvwQwgclNAEsMAthdVHeZQyjcX/8idnc+a4QH8sU2sur+uD45aH9pHmTUkJ
 x9oGiEZgZq5eO23tqeQjJCN0JFaqQ5x9ACR128MHOzESx+SBA1Ui+/CDN3BjE/frPTvlvAIgl7N
 h6XOvkYBhzSdHIK+J2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX+wXrgIRBGeqX
 J93jMLEbFmWYcxaSaShQzwoYMN5F6TYICNVQWzA1qgxArSUwQWM4q3Zj4RCrFkj/A+lKR6EMZoy
 LDt3j6+61xw7sD5eC9NAxCV8zblC5Xc=
X-Proofpoint-GUID: KFWOMxkidAqr7OWW2GkQZ-2S45vxDgPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Here are fixes for two bugs in the same code region, i.e.
mseccfg_csr_write() in pmp.c. 

Patch 2 basically fixes both bugs.  One of them also requires the
implementation of mseccfgH so an extra patch was needed.

Daniel Henrique Barboza (3):
  target/riscv/tcg/pmp.c: remove no-op in mseccfg_csr_write()
  target/riscv/tcg: refactor mseccfg_csr_write() [GL4818]
  target/riscv/tcg/csr.c: add mseccfgh CSR [GL4680]

 target/riscv/tcg/csr.c                        | 32 +++++++++
 target/riscv/tcg/pmp.c                        | 62 +++++++++++------
 tests/tcg/riscv32/system/meson.build          | 19 +++++
 tests/tcg/riscv32/test-mseccfg-bits-1.S       | 69 +++++++++++++++++++
 tests/tcg/riscv32/test-mseccfg-bits-2.S       | 56 +++++++++++++++
 tests/tcg/riscv32/test-mseccfg-bits-3.S       | 56 +++++++++++++++
 tests/tcg/riscv32/test-mseccfg-bits-4.S       | 55 +++++++++++++++
 tests/tcg/riscv64/system/meson.build          | 11 +++
 tests/tcg/riscv64/test-mseccfg-pmm-clear.S    | 63 +++++++++++++++++
 tests/tcg/riscv64/test-mseccfg-pmm-reserved.S | 63 +++++++++++++++++
 10 files changed, 464 insertions(+), 22 deletions(-)
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-1.S
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-2.S
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-3.S
 create mode 100644 tests/tcg/riscv32/test-mseccfg-bits-4.S
 create mode 100644 tests/tcg/riscv64/test-mseccfg-pmm-clear.S
 create mode 100644 tests/tcg/riscv64/test-mseccfg-pmm-reserved.S

-- 
2.43.0


