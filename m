Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A96CA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdv-0007X2-Es; Tue, 29 Sep 2026 22:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdt-0007WQ-AN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdr-00036L-Nm
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQagI1139133
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=grDoRgwfcXE
 Jj43gNYYkW8nuHKJECxisTZck/QXAFWM=; b=fa1w84kP5aYa68WUKMJNVsIlpel
 QPXySDEDp2l6lXVetcPmCT1fUO+mhk49qDcb3KQxCTJ/tPExpiSo0PsQ0xH8KEVy
 2Yi1Go1Zmgv/KjTrMSzSCytL5HsM8oXMxMJbQ0iXyghwHqn7df/X+MH0T2cA5FFN
 KV72zo4ur3Ikqpr3fHpBw6N+p5hEDQo0ub4gCBiEe+bBfEMyHNo6zRYB3FFO/LLT
 fB5GQ07Wq3s5h5vnwjMuNJ/bPMw3de8rCKGcra+U+GS7C5TNqsEufKVeryicHgTI
 d86tDH5jYZUJtfV2dVaNczODd3LsUj4cb0HsH4HgThrO/zPADB866kT4Acg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1kn5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-342b66c0b06so1664984eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733714; x=1791338514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=grDoRgwfcXEJj43gNYYkW8nuHKJECxisTZck/QXAFWM=;
 b=OMYcKyV6F+dIcRFqS0Il34Ogj9c6RyUs57P5HfdO0nUnv4aSzaHcRmQv00n6PYJMen
 i/BqkUc6sTLI5KGuGPvSIzEI5N5457WPRo1A7kRN6f6CHb/j+3djeRCbNa6iKA6GvWEF
 tg7Opxh3MYMMKXeLxrBssrr4CjDI3yNbRigAlac/sJJ+9kSAA3vbzN18SZSXzJV87O6r
 ORpoC8jh2zldFwiIO8lhL/+tZRlEAoW8Hfk2C0tnFxfQ7mXQJm7sF+vCcjmGie7ZGLYH
 Ycv9nhjyrAo09MD58QLYu1k+47I2IWAMfUTLUNYhtp3LpTmhuNBDH6+4PwJhwtCVi8L6
 dZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733714; x=1791338514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=grDoRgwfcXEJj43gNYYkW8nuHKJECxisTZck/QXAFWM=;
 b=csJQV8I9h3eds1/aq98iS2bVJUpiDZIpc9tqb3u4ESZO3o3adYohBYt/PqnK7fAmtK
 NGsESE+KLKc+E09XMRewzAYqo83OXwddF0D0zCT2b+ZV/FnvKgW7ctQNJ7fNc8v9a4iw
 hTVR02/tewHaiQbj8vf9AQMypYWYSsI+KJuJMmCKa11F65ttnrrNMiSO9pIYs3vYubof
 n2eOMPFnwE7eUrFUP7PAAGUTz9cirllpL4Bpj9xRS2tuaSSZQJtSac5xhBVmWs1dBwE1
 tsZK29gcy515I0iyJqIbjiX6UK10tEuQQkcUp5DRq6yiuS5m3Mute22GoNAEqXzkI4Fd
 Vmrg==
X-Gm-Message-State: AFq9FYI1e0vT+EJI1B1iFWXLqsTeyIFSYU8l6nbQ/3ol78kjije2KeZC
 0wmeA+ukx9+W5mBg4qrMPDLjGKZPvnGwJIDVfvNGG37/WP0QxOLAgqvTU6ecQFEPlqP42vkhdV1
 BCjiBLuWtPBocL2X1iG6ZQUYZCNo2d/r/vvu5cJUyukjM5E1aPkczvGrWFY8cH4RR3w==
X-Gm-Gg: AYBFou1KCvblgW5F0O1NyCntPrGQ8Jwtsr0lMpZzwwW7d7aEI7kPbf1cb+Yas8Z9dk4
 SxBkevHgufms1fx5PuTXpoGEfFRMZofv9ZleYNzRmT0VmKuFvNFeyhmWjPSI+hCVPQ8O/nufXk/
 menhv/ofi4+DXIowgDKicTpAN/tED90yXhL1uwHDpRqEFwwAO7/5XOC639cJlZpvNHoc9glqxi2
 mUfRKMgmS9vXLJZhI4gDKi85rbFXN6+ZO9bz2+LFcuCHaZt0HOTUNbxqKJ1bseK7lqLTx2mfsEV
 fYpjyaPG1LD3pu/ZdaKprScnsUg9XKeX3VTufbZ5HRSOZDcBtwufDfcx4/avxjYIZhhoDV2tqHn
 48eWuLvLTjeE3Y3nvvTQNyvlpBxiCbbktQTUbPNBp5rZQX5fjwA4SarVQpRYw
X-Received: by 2002:a05:7301:6193:20b0:33c:43c:f3dd with SMTP id
 5a478bee46e88-34ce3f91a9amr31883eec.11.1790733712752; 
 Tue, 29 Sep 2026 19:01:52 -0700 (PDT)
X-Received: by 2002:a05:7301:6193:20b0:33c:43c:f3dd with SMTP id
 5a478bee46e88-34ce3f91a9amr31862eec.11.1790733712162; 
 Tue, 29 Sep 2026 19:01:52 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 11/21] meson.build: add avr-softmmu to multi-target
Date: Wed, 30 Sep 2026 02:00:58 +0000
Message-ID: <20260930020108.217892-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX5WXmtBkiimQC
 nv6XjO570IRCWI2Z3V6UY+s0KemfhKeof/9ovgha9HKC8ndaBH8xygA11kwXKkwNvELJlkyCkn5
 jbZlMqCMbjoY8Ya8UZtO2xHxyXT5XVE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX3KxgrfGYLayh
 qs4HpkAcK5hvsrbx0ryUWqoEqUjSG3AObhB3+2yiwZELsaRW3wR6s03J7RUC3ItB4G1bGgSJusF
 qkfnEAiwtb/F/JhNW0HqbVe7luwKjmWEQYHIH/0kByd8SrTIojktzC4mOO6Aq5s60cCdXNZ40dp
 hM1u8HwrE8rbOsW5WWlSPD0fmTKsSYyTXywYLyAuXeqQHYyPpDTDOr0WXRSU0m3Rg6GOFYEa0Pv
 FnWAkPYgqM60zXHmzqh61gXLQu2X236WBDx9PrtbpKK2Or/7/rSMN8rOvATmPQ+YBDNNp6Ft1kS
 4xbyTV2DNNt72EUMOym/nVAxtAzyy2W/xocWm2SaVUsi8n4udSHQvyvDKsTrTJM47XOCNWR1mS4
 ZZIpZBno9m3GVJY8OsbSUMNwGqVA9ijMN5TchBxMc6b3MbX/uyQ+UPgszlndr7yAKvCIbiTxu3g
 C5DvNVKbjcIDjWq62Sg==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abc6d92 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=msBuQLrTV7QoIxEg7_QA:9 a=Os7PZhHfeaEA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 9p1HVMxrfjn6lLcu_bw08x5tOO6pxBAv
X-Proofpoint-GUID: 9p1HVMxrfjn6lLcu_bw08x5tOO6pxBAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300007
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 5515f731295..58425a93a93 100644
--- a/meson.build
+++ b/meson.build
@@ -4265,6 +4265,7 @@ multi_target_supported_targets = [
   'aarch64-softmmu',
   'alpha-softmmu',
   'arm-softmmu',
+  'avr-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
 ]
-- 
2.43.0


