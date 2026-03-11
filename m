Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4115FD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AsC-0000pV-FY; Wed, 11 Mar 2026 00:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arw-0000lx-Qc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arr-0008Tb-WE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:21 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AJQouB3892945
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k6jf0c3h/ki2mGNwvU1XNZvZ228so2V/InCFKc9XW7k=; b=kRfmemiYW6SLovUb
 LZpPC5aOk1zmMQ7rlrThy0DT9h/mWP9QFne4bNLpQ2EYiIN+ACgV3aQkHabbsRgF
 6zf5uO3Npy32aBWaJGBV/4keyV9kNZ95UlYZ1MrKUfl3aD3gwjcwspSuri4ynzd2
 bIpdcIHcdQgbfPcelhbkAGC+WKDJdnIZJCQS+a86ZROgMc+C38AALsjPGtkVi/Tv
 H1Zym2QM4fSgrHEcvVoZt7+LEIXcL+AaMwnLuXHb6D46IifcTRinwIMMdXvvkBGY
 YQIpPIS5iD1e8BjC85ejXTxr/qcwwsT5SIYGrG5mLaz2KnBUZqzNORTp5HP5bzUb
 +5IUYg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmyu1ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:18 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-415583a6862so5954599fac.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202097; x=1773806897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6jf0c3h/ki2mGNwvU1XNZvZ228so2V/InCFKc9XW7k=;
 b=a887wBxKxmAdJVtimGMvMhhL+1YneSD7kjM5hrJ9gaylXt0sVGznoo/O6dpvU5HFdi
 dOTQvBEuLt2SbjTxt8q9/jaRxfoMC+HibdzObdBthgFvucJOblZxP4xDP229yHKaDiqR
 R0iCJnP42N1JY13l3+QTp/PvyPQrUGpTRUqzcE0oW4+XcIN9QZc8U+JdbAQnJbKOlmuG
 LnDkoHxUT6gqyGQFqm3Ri0n2Pv+24jxYgTYyj6y5207/5qZUU20h2MArdsepNPiRU8BA
 r+F9S4OeGfje4tZmNmg9ut3lEWo24rb+lm9Gj/CACHPoC4RRx5+fZJ+QrUuzJ6ULShUc
 gIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202097; x=1773806897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k6jf0c3h/ki2mGNwvU1XNZvZ228so2V/InCFKc9XW7k=;
 b=PJiXjmlg5t4lbcRh53FeOkBHLBPrM6Yz0SJ/HTQJBvL0McxVcbzCV17P2y3ID8FZNV
 gfmTaYX23h+2kDstuCbkkMAojj3lXoq13pcGMpRa2sD54GmH3mXhysEN+jUx0kB7xu4e
 ezThaeTYAoxyrB4hUVW2NknApFdt9VALMussX/HS4xo9m8p9SS64mt6ibhCmZMBtQrzF
 ZDDPg7YwcIkug+LyD/TOphhkxPth19uQSS4AhvLu8e/HRlYlTqTj4X7P3d8bRd//p0XY
 WGLhJtksLiLO8iWUd9tN7Pep14ndwmKGF7KD3ZUi20NwK7UyLWZvbii+8e3kjnISwOJs
 gwxw==
X-Gm-Message-State: AOJu0YyzlLYM9wz21i8KLSM2mUfV0UL8KK1u1gObxpPPhr0WMgQDCrMy
 GC7+A4wpaEKZgoqpzBTHSol6hZmF1zIE9iLpR0jJEeufUtj7XIgGphWgSdO4LMNrQPqWlKHgiHH
 ArK586juDoxDFs1UyvAuzj1z8R2Vmo40FXWLHc4qtrZ8na+MY0Z/BMt2SjORhtgZT/w==
X-Gm-Gg: ATEYQzxprSjOu6sIXYsI94XaNXApkmVpRJ6pr9KE5IxJ4E3DipZZABncvBV3tkGf+BY
 EHnssf4JZ+sGquRE+r/oRAKp5mdxgLDJwMjuAcgdAcacaiF36/ll/0jkp+USuGDy93kCAkJVeE+
 SIutXVKDQ+EfVTtbSHK2j7EO9Uav05iV9tPvgTq2KJ6JoUC1ffrVK8acM8oscn3WIdNGSeQxH3o
 ThbLjpr8qBy+tXoaBLOZeQdMTxHgKkn+gTnOrp/oHR+fOSwqXDxE5Swj8n/yQlRbb0md9UBMO7q
 KIqcXeOTxMrhK/WccF0sqzAUH+C7IbAUF1TidFgGk42iO7lVgcFb9aVI/F38+U1d4yl4ADstjzc
 8Ho0rGKEX6mjvEFCSAUDt1czPPci4tmuk4VmMxgR6cAGl+G/cOS1MR8Z1mgdJGaWXhVHjug==
X-Received: by 2002:a05:6870:9e02:b0:417:1bea:8c94 with SMTP id
 586e51a60fabf-4177dcf99a1mr674250fac.7.1773202097446; 
 Tue, 10 Mar 2026 21:08:17 -0700 (PDT)
X-Received: by 2002:a05:6870:9e02:b0:417:1bea:8c94 with SMTP id
 586e51a60fabf-4177dcf99a1mr674235fac.7.1773202097065; 
 Tue, 10 Mar 2026 21:08:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 08/32] target/hexagon: Add representation to count cycles
Date: Tue, 10 Mar 2026 21:07:34 -0700
Message-Id: <20260311040758.1068731-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b0eab2 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=57D4Z9yWObz1DujofsoA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: u38nc55jwZIK-n4KzdU28VNifXj_tUAD
X-Proofpoint-ORIG-GUID: u38nc55jwZIK-n4KzdU28VNifXj_tUAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX3n6jJM3vJvv2
 5Cj7XnxkdLrZNum/W8n4UtPMovrNTs6y2qiRO4LSgYTejxy6ifYwXGJZrZE4qzs2mccsiyO/8lj
 UIn2xd3VU/6rCzT3zCCknFyd/iT6gbBchgiyU11Df3vYlTXjTqFl3nH/4M3E/h2JF9x6VhOcX9Y
 y7xDE+IFetvjs6iWtRYcwDqT6F1FwK4VMCqygui8tCImnMNV/N4vgx0UoFrZqliJDoIru7drW6R
 d7JwKQml76tUwOW6PvI9jd7pkF3xG4wkcumlqxck8KIEYAOrYTNcFWe9u2Itblrq2a9Os8N5U9t
 rRucftGDpG1F3K8QNOnSzwTVOoS8z1qMVnn9vsLH3u1sc/RVZWBLMcz2MZKVUmtubG15HdZ2yZr
 EM/L9Ov90jvEMCFNrnsiks3ipfDiw+z1ZjTCWR1WZIQVZOAoQ7HvKhq7iBv+jQ/+bfBYmFWaK/g
 SzUsvndk9AkddfvHQDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgUENZQ0xFIHJlZ2lzdGVy
IGNhbiBiZSBlbmFibGVkIHRvIGluZGljYXRlIGFjY3VtdWxhdGVkIGNsb2NrIGN5Y2xlcy4KClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0YXJnZXQvaGV4YWdvbi9jcHUuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIv
dGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggMWEzYzkwMTQ0NTUuLmVlMmU1ZWVlY2UyIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApA
QCAtMTI5LDcgKzEyOSw3IEBAIHR5cGVkZWYgc3RydWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgdGFy
Z2V0X3Vsb25nIHN0YWNrX3N0YXJ0OwogCiAgICAgdWludDhfdCBzbG90X2NhbmNlbGxlZDsKLQor
ICAgIHVpbnQ2NF90IHRfY3ljbGVfY291bnQ7CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKICAg
ICAvKiBTb21lIHN5c3RlbSByZWdpc3RlcnMgYXJlIHBlciB0aHJlYWQgYW5kIHNvbWUgYXJlIGds
b2JhbC4gKi8KICAgICB1aW50MzJfdCB0X3NyZWdbTlVNX1NSRUdTXTsKLS0gCjIuMzQuMQoK

