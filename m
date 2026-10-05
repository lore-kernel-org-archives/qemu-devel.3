Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3968FCA5FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnqW-0007Zy-Sz; Mon, 05 Oct 2026 14:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqP-0007QS-LX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqM-0005jK-IV
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:25 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLeRb3044002
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +SRgQkHbZyG8O8fxbS6YPIEowp/2brBTT5DUtJiXd1I=; b=aVNFDKapa1P6J6E3
 TFBX8IvYPpJqfFkKcc4fh9TfHDDgnPAEAXOfhsweOajbCFNyS4qdNJkOxJwBjWLT
 ghKM2GFY6ZdToUj0AZfBB2tJ+nWAX2uR5/ogxqZRJWj+MhvyNMBPxC1NVYnnQ+aC
 XeUFD9LG+j8yQb/oYgJ9/zMdz8n44i+Qsp1Jc7C8PxhUWLDnmjuQ8qPrlyJ7GG1j
 HZHPWGDGSkkBcILFYylpiXvFTLbK8WF7Nfy++m6pCt48m5Qpo7udVIZxQP9FtXss
 JnfofLfnE+IxL1uM2pT9hUc1bHma32vP03WKCbEQDOdBe2f646ypf15c5RmQN85Q
 heyXNA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvsxbd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1416f32fe11so3886284c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226520; x=1791831320; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+SRgQkHbZyG8O8fxbS6YPIEowp/2brBTT5DUtJiXd1I=;
 b=D2QkQBD8AKbfjFIPvItrbVz95lhqIKZoEpoY5RJWgQpVQFXkdMm/Np66260lHXk3+7
 3Rll1E3Q7ozEUCLwPo3m7SNgCymU02t9EHmxjjaAahn2z4SczF6yhbTrW/oiiDQiU+2A
 F2bOYfCGz7v+4ndOcLMYYyKgjrIQxZ/yKpt10feFL9gdsoohlehVrLAshvb9BGmpJ198
 03vJTvz4meRtbMeRfBwql81yISkKHpgj9AMxsAjtoGLiTuSMx657hB/ht9wfq1JlRxtH
 oMTrkPY/5EjRQwiF0AsOrab8HIuzF5vX7q5HBBjAHAAi0cYugz1jSqP54bY2L6FH8Nnr
 4sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226520; x=1791831320;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+SRgQkHbZyG8O8fxbS6YPIEowp/2brBTT5DUtJiXd1I=;
 b=2gTof8V1UK81sJjmVlBKpz0IVt+5Wm+IQtfFBLkqqioBCG83ewhDeuqSK3QFigqs6m
 guxVFZgA4vjNh6DjtJ5GQc4Wk7I1EdShQaud0CHohjaj7cE897fcHwwRygO0P/PONaIz
 upotWtLnWFqSyO2bYyCqkvlPm095Jr7e8u6d5uSrsRcqTJGCKMD3DQnFlqjgpYbyLRpf
 1iz783XUOQ7mV837HIw/9I58Lg/e24/sarwsdEfNi1+GmjRA8woQFF6HB5AgqaP8tvW1
 alPASsTMaQ4aI0fz0xUaQ/312+1d53g7z0pzbIEJDwswwm7O9GI1wrpDjw9cyvYvgWTm
 u5zA==
X-Gm-Message-State: AFuF++mFYk61nV6+9BUpzaHsX6BsyXDZdSVag8KszqFZAFICwZ+DXnoL
 iqp+2gEmKnzM8PcLz3AUjMMgWrt11zjkqHhaj1EgyWuQb9upElk7kJowiCffWhkxB9VduK+eZmL
 RnIqiywkrjiCB1VCatHQiKHxf26ez8xFqm1ueldsQbDf9XBKuKaJUBuHS0/jr5O7LEg==
X-Gm-Gg: AYBFou1/pmjBZDfmoCC3KwlPp5gHcIFT04QDQuc69YhBhrwc/FuIfnR90rTio2H8AYn
 UtZhYduo5Cys6Vb+FcuoFLKsroult6isYit3jFKwh+uFbvaMHJm0JHTyh2yXXho4wxIBxBWwEmO
 QjoHVb1u/bw0p0J+ueFQdm6zZmPgVTtXgx2okL+wnrsuiafENb2qBfzegrW5LaJ6dpQLMxJEvOK
 ludrXDgfWxXKEYuJLpvf1xsv1jlmHtGBJ8+eI2+IS2Lm/5jJmAGegE5iXK/bS1YVgx4wCryVdN1
 O3aADzugjjwR0E1mS/5NVeFplgHQXluAYN+sT1fdfIqS2sts2Vk077kC10a37TqQNYioegVCjNV
 uQb2suSjVx/K/W+5Czdzb3fLjyLBOh5ld+kJmcTK6glS3zePTfcXQnBkn4Fqa
X-Received: by 2002:a05:701b:2204:b0:151:6577:3065 with SMTP id
 a92af1059eb24-1516577427fmr12863502c88.21.1791226520383; 
 Mon, 05 Oct 2026 11:55:20 -0700 (PDT)
X-Received: by 2002:a05:701b:2204:b0:151:6577:3065 with SMTP id
 a92af1059eb24-1516577427fmr12863466c88.21.1791226519774; 
 Mon, 05 Oct 2026 11:55:19 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 08/22] hw/pci-bridge: use stub_ss for
 pci_expander_bridge_stubs.c
Date: Mon,  5 Oct 2026 11:54:44 -0700
Message-ID: <20261005185458.405929-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac3f299 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: p0x0MnJiG25kiNZ9btIklvK1YB9v8_bH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXxHlQTsvLGRrT
 kTYBvVKnc5D8AFegf0Iw0VUKCbO7GR6viJXPemm1K29NbHzCEZSlwwx4qxjS9x1g0rF5DVjDuW8
 HqEUj2ocViKgXN9nj1EQyimPCBZlUaIqNa+qkLQCtEkIndC4dcCU9bnNAPg8Cfas33OsMWSDDFQ
 cOgWe8BL2kUyPDVAhcY6CFlmI4WSbOZWYJVoKSQo0jw0IejV0JCbN/Hvjz0a09pFd91ZTA5u2Xu
 ZdaZA27N0blLFfOmczxi3e471LDL4p91uriJiyxFvOtd/3xK49hKOXcDbQrFIRTSiKdRW0fTc5c
 azViI7XlbrAtt+VEjIUMlLnPjU8NPySDE230bLcslDYTFsVoebCW6wJzp0K8hDJcXO0cmk4pdnR
 U1l28324Ayg3u/VRNditM2aa3M+IVDFvCKLjUOp9Bil6nZiLXrezuRPJNFQz7U/eASM0oi8Roe8
 rv/SL/bvPUVAjgPIwOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX/GAgOEJz3TNc
 5dYXDVNCeZewEK2+UozKXTTDj0ZijQ+bF9p0REiHpFyTXCtCXaRBuUZre2/oNv2LF/n1zhL58eh
 gP+wtRozioVoKHVMDPoLJ2CWYFvT7Os=
X-Proofpoint-ORIG-GUID: p0x0MnJiG25kiNZ9btIklvK1YB9v8_bH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Solve double definition error.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-9-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/pci-bridge/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index 2e0eb0d2332..073aeacf7fa 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -4,8 +4,8 @@ pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
-pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),
-                               if_false: files('pci_expander_bridge_stubs.c'))
+pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
+stub_ss.add(files('pci_expander_bridge_stubs.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
 pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c', 'cxl_downstream.c'))
 
-- 
2.47.3


