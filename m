Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC93CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXec6-0000lF-4c; Thu, 11 Jun 2026 08:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXec3-0000kd-Rk
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXec1-0003E2-Sr
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCSpXt496464
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hNnNky3HjZN9UjJRdWniFH
 KAKKdtx66eIN/zcfAkIJo=; b=bFb/VvNydMqK1MukHrOfn20Mq/LnpuUHKHa2Dv
 ZjO386K9XHmujY/p6lUHsZ2cM5v5e3ge1RsE/uWx3l1+bsoV6WJe7eyzhs2n/uDu
 K9WVvafiI+EVY6vbQb7KRnAW1rXf5M5REBL4V4gXVEqDsNv/8Gy8bk4+1yOnnxmM
 4LJQwD9BzIk3KhzFpRWsgjPnExElC62sQh3Ykzson4v2SIp649Xqb7OgqXCh8sMc
 D6vDLA97ZcKPumeuEiRFnbKRdSwNReBa3EYvnkzkOgRf859M/tdIrMlGDznBlkJY
 lfecd/pKNU+96RdZXWm5pjA6w1p326lj8PNxtHvFLT9SPqLw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ubcv5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:34:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9158f07f5eeso780106785a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781181260; x=1781786060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hNnNky3HjZN9UjJRdWniFHKAKKdtx66eIN/zcfAkIJo=;
 b=O5kpUF6VwADUzW0umHcYtTfyVKUVVM6ZBINtsg5i3K8LSiwdrf95ZxRz4vAZhlt/65
 XZ+aoI6wavdXsMoWFIekEp740v0EoRIY07drsW191yaLjxHAttPSBHrntP75Qf3hJkyN
 n3DSv0w3su2hlK9+XybY4Ib8FXHswjD4ifRsFwZjFjxdqZHN6kwAdvT4+lmKP9v4jUgv
 vY9sMwi/Twqclmd22N9EAAxI+TmVUd9jRLobCn9OF3mpjAapEsPvxk/KgOTQCbsjNVSl
 JGHE70zLSXhiXgDFPsNLQIdo3oa6I42Hv1NSMoNdyuNDPDac4CRu2zqDR+4v3smxWLgF
 89DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181260; x=1781786060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNnNky3HjZN9UjJRdWniFHKAKKdtx66eIN/zcfAkIJo=;
 b=fPNIcwhnfogoOQowHKhiW5mborf9qOv+IFH5R00A7SUeeeA+0frueaZgb4EA9c0wKV
 ZuWcAqyt/3DhZFj8n/YNikzzmwu/QZyOXEejLfTVdiMCkrIFM+spbb+IzWFSmzkqmuV0
 Kwlb5LRyKNKNo5YiTrVENDY3ufYUbAnRN1I0uwLBWAo0SYURuFeb7g4HPuNqD7ToO8mh
 E10DGyNQRgM+CIitpHrGRci2TDjfusc+u2lebZ8a/vBL2soqoU4V9d4v2i2YLAwwfruL
 U8SoUDrF7x0FQd85qM/q9bDhYT2rRdY8NA4zXH/31z2LsKIFSv2jJgggOQXKy34n2DzQ
 FQwg==
X-Gm-Message-State: AOJu0YzAc1CqEUkV1xeL9gxmbjyUCebDYXM1niFE58rS3LL8pIhNQbYu
 1rBxLD6RO5XfrV9uTcfUbmmNuc8MOf9NA+uYMovu4N6Ctgc7+zgPFYTreDsoodx7VHzOjeRwRji
 ep2zUFzNSD7upmbmQIoOyw4WvJ0xcgUd8c+/dlgvUy2MhhvsGweJwM4uwJmRU3tuE+Q==
X-Gm-Gg: Acq92OHfsbEcwc9f97vg4WaCAdwGPezZl7pHO3Q0atNa0lLCmDWvIGZQGffCwsCBgzg
 Me7qQTmAcCjsu1eUKnGYozjyUr0SfKFiXZdOyUhQZVYCY+6MFQYs0iTRlevBaKbjhNhZLTJErON
 xI/h4euB+51KaRKqNGoG7l3MUzfv3eCJmsktaNSboK3ng8auAkexeXOP1EW4KhXLxdIfySX7J+l
 EYfdIoWb4iN4w/cdI/hCQCH+deDq88eIakRA2Ud0fHsvQCGKkqkobwhyf4uhzFjZXkG/1dsxh+P
 +LZYKPROQu9Np1CcdRoCR+lFpFnyZSgRvCV6TJtQ+KKXXpCPnwB3BKDue5/Ts5WdaiP9rdy1xvm
 jTZYaeg/Yw3YkC8hy7DK2zyzGiMTqxIqlw+q/9zrXU+wHNzLgv9Kj147SqHmlW/52Lh0VDuGu2i
 acSq+QT/103RnSUHoSPA==
X-Received: by 2002:a05:620a:3909:b0:915:cf88:1e46 with SMTP id
 af79cd13be357-9160ae27848mr368226285a.43.1781181259741; 
 Thu, 11 Jun 2026 05:34:19 -0700 (PDT)
X-Received: by 2002:a05:620a:3909:b0:915:cf88:1e46 with SMTP id
 af79cd13be357-9160ae27848mr368217985a.43.1781181259071; 
 Thu, 11 Jun 2026 05:34:19 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (201-26-7-9.dsl.telesp.net.br.
 [201.26.7.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9160acd7904sm181042185a.21.2026.06.11.05.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:34:18 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 0/3] target/riscv: parametrize debug trigger number
Date: Thu, 11 Jun 2026 09:34:09 -0300
Message-ID: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfX6709Xx/9NZ2C
 mVnWS0QovBFBkoHWWo42hn9Tr5aJhEHDzI+ejkj9fWwdYo3jMLk/DSc5bkl/u1PailwS9UF17NA
 EIk6ZiFESDxh4CB1g3Y2yq0b4aD4hTw=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2aab4c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MITIYaLR+oYcSln1dApPwg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AdzE5SDVa_Qk8pGJHZIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfXwwoJE0OShp2L
 9lXNTiEE2hRzGdKfgAsizzi9A8Zayh6O/5T8LDZG5aqmueaaKmoJX1K5//TJdBLbVnnqMHvW5B1
 fInJ9Ytw5fI1mCIPUsSaOSBiQBH7VJx3qL43+1d1C79WJf8W2AKKVuVdXXxDrHBAUsMUwZKAyob
 fgImaqUzvcB2vdKYKjz7tMsHiKrJdkzGpmofDB1v7qc9joGo/jWCZ6E9p8ouY8fHGLH1o+v2lIG
 7QhbGNRJYuLUSXMKZGKYmcc5Ch3J3oKm6AJfSOSun8P5y58wb3tDz4G3swFuThN1p8qRF4ytTtf
 ZdJTzZsEjgPdZu0OpwKzOMWYr3dgDODCrYwZ7nqBUus996AWKl/Acy8xMI6ZwjS/krHCu7t/tfA
 z+t9qlRS3c7JJNUfdSq5q6S1bxel6wdi2G/+ZtGlQQ43QHy5fmAFPwNeqCabfxN73lDS7mnEQew
 ybdKfpdWCFOzkQ0iOsw==
X-Proofpoint-GUID: roGrvbdwn5jMNVAFrhxLJG9JiAyFd0pb
X-Proofpoint-ORIG-GUID: roGrvbdwn5jMNVAFrhxLJG9JiAyFd0pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110125
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

In this new version we're adding Phil's comments in v2, in particular
the need for an unrealize() callback to free the stuff we're now
allocating.

Patches based on alistair/riscv-to-apply.next.

Changes from v2:
- patch 1 (new):
  - add RISC-V CPU unrealize callback
- patch 2 (former 1):
  - free allocated debug trigger arrays during unrealize()
  - change version_id and minimum_version from vmstate_debug
- patch 3 (former 2):
  - do not touch vmstate_debug version_id/minimum_version_id 
  - added Phil's R-b
- v2 link: https://lore.kernel.org/qemu-devel/20260610205457.1868701-1-daniel.barboza@oss.qualcomm.com/


Daniel Henrique Barboza (3):
  target/riscv/cpu: add CPU unrealize callback
  target/riscv: dynamic alloc of debug trigger arrays
  target/riscv: add 'num-triggers' debug property

 target/riscv/cpu.c     | 26 ++++++++++++++++++++++++
 target/riscv/cpu.h     | 39 ++++++++++++++++++++++++++++-------
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 46 ++++++++++++++++++++++++++++++++++--------
 target/riscv/debug.h   |  1 +
 target/riscv/machine.c | 16 ++++++++++-----
 6 files changed, 109 insertions(+), 21 deletions(-)

-- 
2.43.0


