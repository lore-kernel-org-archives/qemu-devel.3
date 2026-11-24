Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE25606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hmwvt1S9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MppiyVDb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzey-0001L7-Oz; Tue, 24 Nov 2026 18:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzek-0000mM-SZ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzej-0005BZ-0j
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:34 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMajc7886177
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1Rgqki2VOaXpm2hdQ7hC3jm4zNS1aZ2TzbBnqlu2bhU=; b=hmwvt1S9IUUTFiU9
 iMTJ8FYqjrkvqmPtzaQJj8lGZQYcp4k+s4diwcWlaYNWGX0BfI23Kq/Jpm1jP2+G
 HUPLZFf8HJU+eydIXLRhpqO40gzpPlfALEmbtkKKwenqvZm/dHr7ergrPTdFf2p0
 tU/hvQZScy5LAXxCcbFMBd8Odu9LvI5yvc+n10iNn1J8UeMC3HBZrUHQ1OLXeDMX
 FJ7iCdT51m44D7W/7h22Q+G2jOhV0gstqCPwJnmzgH0Awfwbf0yMeajyytschtV1
 a8nj/mpez6cah5/Yj6eVfnmqOwBf8PeymbBFKdTr/Y80CEle9atblZwISZ9maclW
 BQ+KgQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rhca2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949b0d3232fso732371785a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561830; x=1796166630; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Rgqki2VOaXpm2hdQ7hC3jm4zNS1aZ2TzbBnqlu2bhU=;
 b=MppiyVDbf7ozucYYOQrFcyWdl1SNIWkUJB9sP0EJXWdsudXfRJLOfr5kxHT9c2+rTx
 9HfwubfJRr3gU8ufhsB201e9BeTNL8ctDKFXmx1YJzAMvulZjqrGQZg9xPU5JS1DxyFg
 rTxipLIrkOrmnwkWcrqvREOeVgWQtjujadcEnl/NAz3WvH4jaytkTEghJoEYe/RkCFCX
 cscEpoAxCy8O6Yg1LlW11OmQeZ5K6EpMPNcNKKZxPoPja+FzhttirxRKebN2UMU3p5S/
 LrarCM/40+rfeCQJm2Jlyefr0VGkmtoXVkrYP0O9MHX23fR6polAzQFe8b7x+AzdxqOz
 mDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561830; x=1796166630;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Rgqki2VOaXpm2hdQ7hC3jm4zNS1aZ2TzbBnqlu2bhU=;
 b=cHJSpBLlryNyHpsULD2Mvm+JJct0FPuQdvXe4w2/s3xXtN9hT7gJWa9hhDw6IGUz+C
 tlLfzCzQkyFIHMP1FbAtCUiKc1KWgb3xdviwDlAU9VAX1PT/nxY3jekUp/wXScABPDEL
 8fzwbRu7IKPJ1G6buGP18/TCfIH2TGEQmjKXImO5jzrKXQqElgYcaTHzTIZzlAyWhzrZ
 sb0GIgT2IWtSNlMI8+b7xZZB5mTID93SoR832wLCZk8qvdrm1lud965k0mbadbaf+dLu
 kTegTJH3QIJzqbGroXhKSx3WY1lKMfJAAnk7gliC3c1usjwiBTl3uF1MNQdbjPWbK5Vc
 N5Yw==
X-Gm-Message-State: APuU4Z9V3s5+XPRH3+/YorKe5z0IstsaTe6rqZDnjSDxZ7dNgL/Naoeh
 n2sg/YoE/eSC0C2DGUjrOwqF1OUevptAH61FJ+HPersoz7NJ5ZaK0ckDc1zDK+dwvPVoupudc/b
 5O/LTYgNLL72pa0H+ckqMiJvdWxU+oQ0pUaKKp9FTc6VCPTrCPIZHlCeeh9hqr45TRkvK
X-Gm-Gg: AZFdTZeVxdwz0eeDBpgOoITZ1x0fl/PIhA6l1w7ETeKJufOEERB8fxB6a/ufdciVUuV
 NQXQhQR16HE349T94hsqh3m6CFQoRxvqz2pVIcOBPDoptwaCIBpqvsR/PqA2V3x75fFaWqYoNiA
 AyBrtaaFQS9Feq5E8M2vBsMCc0gViaqFDTxItrCuOYumcKOGTQmy6zGbhuPIenwv7In+Zlwuarb
 rCpwCgrzsav0sftX8+tWQy9woeBjCphd8pyqZHK0P4IMEqdvRpxXy2gaKomOMa5Sr8zHTHZxtR1
 hnti75D8MpwdgHF+1eWLB0kCx4aiC3k2xa20pBev1ZRYRvwSb1I5eQ5s+V8QarBWmpQ7xswI8ms
 7MlXzYLiRnluwAvS+GXXQ9eCgEs7hyheY8RjWjFMBpN1aP3+LWdDB6BsPztKN4kZhNMIgj2iz3q
 GgOQ2JfgAmuzFfeA==
X-Received: by 2002:a05:620a:4625:b0:93e:c12c:43fa with SMTP id
 af79cd13be357-949bab78b0bmr2784241485a.71.1795561830427; 
 Tue, 24 Nov 2026 15:10:30 -0800 (PST)
X-Received: by 2002:a05:620a:4625:b0:93e:c12c:43fa with SMTP id
 af79cd13be357-949bab78b0bmr2784235985a.71.1795561829748; 
 Tue, 24 Nov 2026 15:10:29 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906d6a13sm248464315e9.3.2026.11.24.15.10.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:10:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/17] hw/display/vmware_vga: Reject attempts to set resolution
 outside VRAM size
Date: Wed, 25 Nov 2026 00:09:10 +0100
Message-ID: <20261124230917.88704-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b061967 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=LSjrgreAm0ToU0vYokAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXzDXAfpDDKJH8
 QDE5EvePjAeIj2LQVxsS1+c3KXRCIrtVrlgMXPRiHr6qdfocNrg/1FCK9DrpvINw5+fz46x0z0c
 10GZnsFAKmBYj9WFMbR++9kE6S5jE9g=
X-Proofpoint-GUID: 8o-7lQUd14nH6bwRvsZwbSvZCpgOs5U4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX1vD8TjROyhUW
 lG76VoOJRhJ5uV98zsFZdR8hJ31LnWC3E7DZ2funwWGMlcLkIcNgL5FtHEyti5LxafDysCIHlkk
 83zFF64D3ldZ7zgl6Y+YCs55WYVPytQkX4HsiWO48+iqw1yBUNHqIGpnqRm7naekpAwFXnd3zFh
 jNFT1l2DVYr8fZdJ2xfjHe0BGbeiOUZelJwhp5LCKNNAwVnoFiWRwzY5qZVz2jc9v2tKUdMxBc9
 cWFxYzIvfYvPxXDcG227/3ruZl4XPNd/cCncRybZn/RMKnCoEYhyAOWw27wAJi3Y6hYW0uMkG0x
 1J6kjEUp+keNe5XMPQSM73eJYVzIPPVmQ0JcQHm/nH1DvwRdPSa+BbJjOD2nByBhGPfUzrfKDoB
 2n+o0cRE8yZ/dxPC5hJzhBJS3o/QSoyASiYT39/NpecDkx7Goo3Gy9amTo3Sf7tWS2LmIkYyF0+
 QZwYNUAT3FOO0ABfUrQ==
X-Proofpoint-ORIG-GUID: 8o-7lQUd14nH6bwRvsZwbSvZCpgOs5U4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The vmware_vga device limits the maximum width and height of the
screen, but the maximum total resolution those limits allow (2368 x
1770) can be too large for the configured VRAM size, if the user has
set that to something smaller than the 16MB default.  We don't check
that, so we will set up a display surface bigger than the backing
VRAM and QEMU will crash when we try to draw it.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4898
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124095719.4126146-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/vmware_vga.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 353cef408d23..d4fff4619817 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1136,6 +1136,11 @@ static inline void vmsvga_check_size(struct vmsvga_state_s *s)
         pixman_format_code_t format =
             qemu_default_pixman_format(s->new_depth, true);
         trace_vmware_setmode(s->new_width, s->new_height, s->new_depth);
+
+        /* Ignore attempts to set a resolution too large for the VRAM */
+        if ((uint64_t)s->new_height * stride > s->vga.vram_size) {
+            return;
+        }
         surface = qemu_create_displaysurface_from(s->new_width, s->new_height,
                                                   format, stride,
                                                   s->vga.vram_ptr);
-- 
2.55.0


