Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6707CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 23:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT75W-0007Qb-4S; Fri, 29 May 2026 19:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT75U-0007Q9-35
 for qemu-devel@nongnu.org; Fri, 29 May 2026 19:58:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT75S-00054m-Fg
 for qemu-devel@nongnu.org; Fri, 29 May 2026 19:57:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2FXT518305
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 23:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=brJioxtAd913KdzwyRI3ph
 uZQawl4wTwKFQmRoqZxz0=; b=LEkK3u/ntxlZlbkxXpkgRJHLVzGZpzjrBVBpQj
 fcGz68R517G87Q8yO9T4ARNsif4+uyXRpWz2NhsC8KYrZjy/8TWGkHKeu/I9JdDH
 4Ghptfa3k8xJHF0vTuCDs30dn1KSCAZgrxZrytBtJ2FM7Y8idv/2/xghswhqII+B
 KfqAegIgvg2P3rKHOF8UjxQFOsJqyITvjtcScbqNbvsNb4xm0G6tTKkc7C1R/zyR
 s3rr43ApHPHylRTqCqcPF0ZnyqwMWcKOgwgvHIt9ia9IXd6kcsNr7E+QFcpt01XF
 Xs9vbm4clHtyzZY5RnYgkwtJhoDDeP8386x6jqSzeX7jahuw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efechhypn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 23:57:56 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1329791f18fso22697474c88.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780099075; x=1780703875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=brJioxtAd913KdzwyRI3phuZQawl4wTwKFQmRoqZxz0=;
 b=Y5Ct2lnmHYb+qhXMfE70Q0Ist6e98HU/O9ki1EYcodB7DJHYGUiVeT6zRedaDyOCej
 DNi6d90hI5auw1pzm6vN0IdePzx8ru4ClF1NH05aLvokfZ5vWiCzum+VSVl3KZYI927B
 0Dy7k4iU7ldTeLZW4ecG0Oty7k2Gyd6BeNDsjGrCsGEZAxrH7wcQO1qvvgZ8iN/E8N7t
 sJMVolvHx8/qIS1DuCMlNvgokRLahzCDKbxZ+eBCdhTWv6vVP+OH8f6xIppMdQu3Dc3C
 BMyjPGUNNayWWw2tKjenrpxjgOTjz67AvkxikA0Hm0BT2dC7Vk/3jaGN1Uxc6DyU3KKN
 f9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780099075; x=1780703875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brJioxtAd913KdzwyRI3phuZQawl4wTwKFQmRoqZxz0=;
 b=hN6RMqM0f0IFYfYbp4UV8ePH/9m2lrhlBqNjbvWST9gEeHnz40INNuh3U7TBBR+pNw
 MAa68UpCs1dL5YyBsdPv4vzEF8fc6cTIItKjmbPkT1RadAf2aSypsSOqOO9g3uU/lGPX
 6+nDCEYYvo1HQjEin2yQDdNQ1VKCz2y5QJlMhNZmfVWJOVGVflIseuIzRuIDkfTxLY2x
 MJqx8tGyE6LRWVFre9PGR4wfWDsj9D1GSFlmEhcAG1U5LhGGKF3+okrF6DAbk/BVjRrv
 VekQUqdfZH5l3e0Heyyg3PyAr5FoE/ja7WRrWitXnJktxOil3A/9T5DUHf3JbAsOCBBS
 tcBQ==
X-Gm-Message-State: AOJu0Yyz7fqnEVmVj/UO1iLs2N2Pc44a6EfX6dcVfam2Co9ZdCq5qkcv
 egMj47pCn07teW4fE/JAueOfOfm2LDzTA+uqUlMT89UrFngNeDPqy9NExTWbX62/CWMDzHHhV9Z
 AOWYFThyfqqhaXHBetPOweZJmZx5AcxHcZmmdn3FevCZgeXkiOvY4dXsjSparI/IX+Q==
X-Gm-Gg: Acq92OE03KyXB4ioByxqcDCE941eFlfJ8qo9QwGNw1BohnYGNE8OZwi2m4RfFF1BQJM
 uXEdAphypz22eRbM+X5pCGoYxg5y6MIvCcJG0xOoC3E2U+/LczktM65y7dJeZtsoXXc8jcwtBtn
 Pf83CgyL1EPkqybZC1FFsS3D9iKwe0WWYf+/7vv/VcW/Ro6pNuQ5p9peHiNIygLbM778V4o9LV1
 t7witQtC+QKx8tpO3y8YQO/gIRNMQO8IU2D31sffYFgltD/m1eh1uzCnlGWPOSJtZ/9Yo9TzJ3q
 QRd31o/81gWzzmdvxfzByzCLqAVf8DFeuxxmjEADsuks5xeI/09CdVPxD8Fyf3p8lvbPFc3LmFv
 ISRkTzJfSytqPD/pX+kNAvI5tLij3WFg9lKEG/GsQwNtRg3/NJRVDeYIwV1dwvSIcwbbzjCL87t
 3mQBgG
X-Received: by 2002:a05:7022:60a4:b0:137:6781:7dc5 with SMTP id
 a92af1059eb24-137d412b5cdmr954713c88.24.1780099075277; 
 Fri, 29 May 2026 16:57:55 -0700 (PDT)
X-Received: by 2002:a05:7022:60a4:b0:137:6781:7dc5 with SMTP id
 a92af1059eb24-137d412b5cdmr954705c88.24.1780099074721; 
 Fri, 29 May 2026 16:57:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b36aef95sm2143282c88.4.2026.05.29.16.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 16:57:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 0/2] hex queue
Date: Fri, 29 May 2026 16:57:47 -0700
Message-Id: <20260529235749.879787-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: moBNMVwvtbzmtTLCZZtYWksHHYf2Zlp9
X-Proofpoint-GUID: moBNMVwvtbzmtTLCZZtYWksHHYf2Zlp9
X-Authority-Analysis: v=2.4 cv=U6Siy+ru c=1 sm=1 tr=0 ts=6a1a2804 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=I87rgfqA3SXR6dar8UsA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIzOSBTYWx0ZWRfX1Gfsu1VpCeUD
 dthgFDMk14ZYMe6PoA4CgVfYrubXpXHaeLMyYqqtvOK16DriYh3t8+cHeNhYybLJYjYFWf3mvrT
 rsJR6GQktwBQZUJU+HVeSiE0X7L5rji6QWGtqQ0PnOzyrNq103MacJUuq+VaZgrcQr8xul1uYtO
 8i5pB/KxSS83lr2vV02i804vU/HQxDMl78MeiCC1sr6H8d/jO/1CzJvY8bCAHA/aKmuRvqGqOVg
 3O9B17qzx40DWsVnw+81oh0Q0i4c/oGQB0ywVUk+EtrxgpxYWL550EFThsUCHA172gb1tWhmi2w
 Z8hU/E1voRqW2aUyovoUiiGvpbcPHRHlZO1VEEyqttHWvUvKi4epuaugEgYkh/mn8LER5USB3yF
 rMVD5kh/McqYed30NKgim7lyprTh4+UbC+rfQY1KrqaUBQqJpxrEap0CVNfYMIOM8KzHULfVfzV
 8WgDvMbEmr69jYqk0Jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290239
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA4MWNjNWYzOWFhMzA0MmU5YzBiMmVh
NzcyYjQyYTJjOGIxNDg4ZTc2OgoKICBNZXJnZSB0YWcgJ3B1bGwtdGFyZ2V0LWFybS0yMDI2MDUy
OScgb2YgaHR0cHM6Ly9naXRsYWIuY29tL3BtMjE1L3FlbXUgaW50byBzdGFnaW5nICgyMDI2LTA1
LTI5IDEyOjU4OjI1IC0wNDAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkg
YXQ6CgogIGh0dHBzOi8vZ2l0aHViLmNvbS9xdWFsY29tbS9xZW11IHRhZ3MvcHVsbC1oZXgtMjAy
NjA1MjkKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBlNmE4MmY1MTU5ZjZiYWRhZjM4
ZTMzNGE4NjNhMmJjYjNiYWFjYWQ2OgoKICB0ZXN0cy9kb2NrZXI6IFVwZGF0ZSBoZXhhZ29uIGNy
b3NzIHRvb2xjaGFpbiB0byAyMi4xLjAgKDIwMjYtMDUtMjkgMTY6Mzc6NDQgLTA3MDApCgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCkhleGFnb24gY3Jvc3MtdG9vbGNoYWluIGNvbnRhaW5lciB1cGRhdGUKCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQnJp
YW4gQ2FpbiAoMik6CiAgICAgIHRlc3RzL3RjZy9oZXhhZ29uOiBmaXggY2hlY2tfcmV2X2dhdGlu
ZyB3aXRoIG5ld2VyIHRvb2xjaGFpbgogICAgICB0ZXN0cy9kb2NrZXI6IFVwZGF0ZSBoZXhhZ29u
IGNyb3NzIHRvb2xjaGFpbiB0byAyMi4xLjAKCiB0ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZGVi
aWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyIHwgMTAgKysrKysrKy0tLQogdGVzdHMvdGNnL2hleGFn
b24vTWFrZWZpbGUudGFyZ2V0ICAgICAgICAgICAgICAgICAgICB8ICAxICsKIDIgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo=

