Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54833CA9EC1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFJSU-0006YH-LU; Fri, 09 Oct 2026 18:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSO-0006Xo-FD
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFJSN-0002eJ-1q
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:52:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhaKw1417652
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 22:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yY+vUOYhuKM
 zUIDdpkdugyJdpsI4HUaH+fcYN/+AH3o=; b=LfspFUgyXe8ylMBECQe+balmf8Q
 idMaGniiCKQOHYPKvMqC/hT30ZF167HHlN/q+J9GwwyFu3HtqKISQf5Zrlf4PNDp
 AJf/+hdP8mZyej4J5ds5YMK95G1DWuvL3kNArPJ9AKmfSUahkR9enel6r0Wtny1+
 DlQGC7eDuVhnQ7wdjlLvzdETEIqVuWgj3PQ4fPdC7ViIVG/2QcnxfaRDzb1XCDOp
 iCSmX2VZIHoXT1KKr05nz0H6ekUegCaazDOnzkZ5PUcuVZOx1qISsOPtLsrj/7nD
 tqozJMFv7Fg5P1IvGsDOz+kmQpr4AUiUqpxc3AgxvDBYxlDxu1P+gqZw07g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t891ag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 22:52:49 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-168a8884006so553564c88.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791586369; x=1792191169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yY+vUOYhuKMzUIDdpkdugyJdpsI4HUaH+fcYN/+AH3o=;
 b=KYNgA9Odx69OLw5jZ6SZGHQuRTNiw6h0EHGw2TrzHnVEPAcQiX8XPQSKIDc4jghYsw
 owpuNxOrsMH8F7NIeNUOHQ47+1p8Wgimi6oRX2P6qYEr2Dlbg2Km00br+i1ExAHncLFd
 D50YFsL44OaE3GG8lDz3jsdSk3naNmn5czOb76Z3bH4nxrw0BrUJSTsVuNPP258IxoEa
 iCT/vnpHL5RyyVKuC3toIq+CP5edHHekHaIvamDbpCskYZ7VZJtDFo5x1EiERe//wfYG
 rzui1s3403leMfQRVn8MinpY1yWZBPXAMnu2IF2KBXbvB8r5ZrGLe7ikL9WUrjy5EsmL
 gWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791586369; x=1792191169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yY+vUOYhuKMzUIDdpkdugyJdpsI4HUaH+fcYN/+AH3o=;
 b=PQ3ddan28QzwbuF2Zhbyhb7KFsbgBmYFckVrfwv5Xd8mFoUVPwm44950jo9f6mfruk
 Q7SOJDR2dpDDVb75yboTGusOvk60gi7grNDJ9FRlfBv68zsQzpKzBVI4jrJg5d5wOVVv
 iUQ4jx0DYXHwVRIMdm/kIsKHlg1/jOZ/DqWoHz1bICpUxKqU3aGpis6/zPXk+rLmx+8H
 touWEGUCno38P4dQmuVI0+5pNNqONh6ypNDyQsXkGI1YW851p1WyNpbqn+JIyweNAHdk
 KcGWmxEYbFe0LTpgxwrA/vlj5iXRDXOGMu42ES5XnTLR6x+Rkrf6HXyJ1tL9nMowYfTO
 1ZlQ==
X-Gm-Message-State: AFq9FYKo4r3Ps0n1VhmMWKoQmzGA4xjqkKQeQcVn+W9IVxlFbZkScIAi
 3WYSsFRkW5CmCGSwOSN2VmrmLeJ6H6Gqpbo9u09a0lfqiOpZ7vFfX11+KuxJpUylrDBkmwolFB6
 IuSKbtptYywJmeYgwb9wCAK+hoQ+GG6LdB09keK65C3GydWGO7Ev2Pa9mvZ8j/mPjdw==
X-Gm-Gg: AYBFou0YQ8Cm19LchSckcgOEUOMEaGkacSfHAQJZ3VpjfKyqR8+a/+VqKr1juRuTl2k
 mVxaPRxI1YYpNUZp+BPHJtPTsq9eJQ1XSFE7Gz3DRyqJRC9RYxmXFfnOd1+U9nwFBW4b1f6HbLS
 oWdU5+iLWP1JYjDLGTwnAA4p/CVKERS/vbN9I6gvm8tMGihgac/ik2c/27ZXdYignhBFAB4e0Go
 gdU1rXejKHjGr+YtZTFlzwVB9hBvGckCDhmVVtMYfVOd1cAExqi2BDevUx2L4hE5/J0R/T0mQo9
 r/o/lLCchYOABqKuLJUh+sNFwkdsKzSzibKSocLypzKkyJ/bsVTwAHjs2bTqhiUKGAZchBJI+ad
 6nQxlx8C7BazWd2fpwM62aVfY6FPC2YIL2NgS47rZmiJ4kIXMy5i810OMbZ2p
X-Received: by 2002:a05:7022:7e0d:b0:14e:cc3a:9f32 with SMTP id
 a92af1059eb24-16a5c5f2df9mr4549397c88.7.1791586368995; 
 Fri, 09 Oct 2026 15:52:48 -0700 (PDT)
X-Received: by 2002:a05:7022:7e0d:b0:14e:cc3a:9f32 with SMTP id
 a92af1059eb24-16a5c5f2df9mr4549371c88.7.1791586368446; 
 Fri, 09 Oct 2026 15:52:48 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8443977c88.22.2026.10.09.15.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:52:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 11/11] meson.build: add hexagon-softmmu to multi-target
Date: Fri,  9 Oct 2026 22:52:26 +0000
Message-ID: <20261009225226.10657-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VjACnJf1aTTfxiZ250QY6IxNbvEiyhnf
X-Proofpoint-GUID: VjACnJf1aTTfxiZ250QY6IxNbvEiyhnf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX7DUsASXn1Nwb
 ruPvs+6HCzFGGGstW8TkOJ+3aTVbTbfxWfrycqjN1Ckt3OaQyKg0UlDUTfPVr+AXqOUgdcmZ7aj
 D+30uB5IrEArtcrXwJJMcN8s7HST7dY=
X-Authority-Analysis: v=2.4 cv=JuNkP84C c=1 sm=1 tr=0 ts=6ac97041 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=LwsoGGQ9uPvd33-Ta1sA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MSBTYWx0ZWRfX7OlowLMEOhcn
 0vpfDieT/8tHIdlBPJTkNttkEyxAtEaBciBGijiKdz2GN1mwhCtN1bAmAFFQJyhDdI9QjhO0nd2
 At6O66U9jhRpTGP8Zsd2ZB5yH3Z7zaqGTq4Og3MDtHgoFldLAKJUXhHgMYOgXe5/aWD4zLmrIWJ
 kJABBA9S7A3yZ4M/39d8wX0u0CFFkI60CAMcsZWRaX7CRkSjjCETeIZtrcMU1cj9xepQRNpQH4C
 88P6hi8VtFrSgSL4DcwTsGGnva6s4t5vaapWmopC59IbVr3YHiZKa9Lj88wta/2Ao3zm3vRklym
 J3k60cr3aTGlpp9PSZ+M+TQjvJxaSc5aYtF35bb6TE8niLSVbiA2B5j6mCcQoaaT9IRtYOtIiD2
 cjWeW4zNvC7KRKKmvS/X9hmXg9oDrLfrABCD/e2+66BwhtSIGpKOq6r4MEUaYmoAKuOK6MKDgUa
 GKm/l2f4r4wd0wkxXoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090091
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

Now that semihosting is solved, hexagon can join the list of target
compatible with others.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 48da6cf3e6b..367f3b296c3 100644
--- a/meson.build
+++ b/meson.build
@@ -4273,6 +4273,7 @@ multi_target_supported_targets = [
   'alpha-softmmu',
   'arm-softmmu',
   'avr-softmmu',
+  'hexagon-softmmu',
   'hppa-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
-- 
2.43.0


