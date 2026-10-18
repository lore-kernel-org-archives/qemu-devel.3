Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36D8CCF2D4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 23:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIZuN-0001Al-F3; Sun, 18 Oct 2026 19:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xIZuL-0001Ac-Hd
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 19:03:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xIZuK-0007rC-5r
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 19:03:13 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ILjcOc840156
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PRdRT3I+2Qr9zOeyTrt7HB
 iOoRTC08GbSmLdcEwHXjU=; b=Ek1+WxZy7gYgdnFLlXXmv7v41letBJCsb5yogT
 3hxhBz2+kyOHmh+KCWeXHBXQi66ALDVegOYg1rJEpVsX5saS04n27yd5HVkxveGS
 ZI6HE453w4OYlCuWv2PXlVncNglRPVuiddxLRhbkEwsCHkf9B3yFGtl8ImjaNZhx
 0XJamCXQCfT+dp0ef4lc78R8b0YdJNqDPC4ZiQpV9XLnxeA5sL/y427V/mtXmhP6
 kf2Rxf/U1QF3CRiu0oHy6WzgB9Bs7RiGMsRP0/4tPeMUz1absPHwoTIycSBKW7cl
 bZ2G9opfx2H0UObZW0jpW9iN31U4GVxTZlx2CMYfFhCWHBKg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1854g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:03:08 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c82cf2652dso701040e0c.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792364588; x=1792969388; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PRdRT3I+2Qr9zOeyTrt7HBiOoRTC08GbSmLdcEwHXjU=;
 b=hU6Qchxby3ifitAFveNasNK5ctz+tR77K39aFS1v05B6EVRSlsz9uj4imb0IguakLx
 DeeTw2E86MvIfWI0X8aAcR1Ir6A19rmatILZG0pdWwo0QnOGZSfaWzKK4utUdnaBEBVr
 UakRB21P9LhMi3cTV4Dzw4CrksFjYRfcCAwd16lK238U6kw1sTT+9EDLOs7UdeugqcIz
 iKdjRj+HwL3k26/HCRt8RtHsIQm+SvpAFas5T3Ir0h2Nc3sgmT3PUSgndPKyZ6Bzbk/R
 3wXxAQjbSTYXh7HWpegtNXulY/oQcGW0cyEHB5wIb9NpuMMeZkqZPcUCojCE9d9/DGmg
 26DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792364588; x=1792969388;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PRdRT3I+2Qr9zOeyTrt7HBiOoRTC08GbSmLdcEwHXjU=;
 b=ElSsblEnYEbj939NbFIQ3sENSQXR2BatNFCvP/IVN+g0qo5JizKikmkub1FMLTYVgf
 50ysXGuOxaeJbVHauopjsWEgB56+uZWEsp5hNIT9zzmVdpOfX/sXNyRpLn9IQAGLsx3c
 soaFL7G0Tt/KAh+8RmknBDRdFYMQCqOkdQgVnuijzIlBt30buSJaYjaS/KJKKGExptXw
 TndsY9vc5Hh7ztFtBo0FSa5JggAq/lMFmE/q6cb131HVHLalGcIEGGFIO8wNpSpHeTvK
 jNVqsX+LggECNVO0cpDhYPYvvsxv0B5fsiJAONf+n1Yt38732VdhTNtudC6OnnKHKMvR
 ti4w==
X-Gm-Message-State: AFq9FYLiEyztBo6lmQdQY2OqkCkAPIQQQpUTGbS1ar8IBi4pcUkoRqDw
 ul4+Lknl9yWxyTidNPUzS2NkVxwFVOJNtciWTSxcJHEbESQnxk7W0WirFkIDbumL86fmn5++6iN
 mdRe+6CXhBYrd4NOzqbNKoj7sVlXC3wQwfglhdrEgLjSm+/fHzRLTMV2v8XwiEyeong==
X-Gm-Gg: AYBFou0RqJtE3FWk1r1PPIi65KhhUkelfiYWMzDz8sVEtEp5x+OrzDG+8vQX6nB09bn
 UXgQpag8NDI0cDngigYdPKPJIXN3QnkvWGNpYUALpYWzcT2PzgILxEVQi67SyBVkXl3cOBZDDDr
 gIoLjRYsQeHruxPoesN2TNODIOWmdz1o/HfT7ldl8VUA0weekKn6dctH4jNyzLI7XpJDq0L7Ewh
 AiarpQN7+K2CjtbIEjTNcZ+HWRoa/1st4PTXWCKmsxFyIZ6R0RYLwI3RSyE7BzWODUMSShmiYiN
 usEqrnr26e3ADna2wsDNKkC04S6iRwUpNoMoLn5/0psNp0CL8Tk79lccEKOPjbIN20N7vtjBRKT
 hqg/upk3B7pc4NBofbQROtjt15wMDJoSfZ4uXZxUG
X-Received: by 2002:a05:6102:3f8f:b0:7c8:1fd5:82b5 with SMTP id
 ada2fe7eead31-7cc3697a7d4mr1431215137.14.1792364588334; 
 Sun, 18 Oct 2026 16:03:08 -0700 (PDT)
X-Received: by 2002:a05:6102:3f8f:b0:7c8:1fd5:82b5 with SMTP id
 ada2fe7eead31-7cc3697a7d4mr1431212137.14.1792364587734; 
 Sun, 18 Oct 2026 16:03:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ddde4esm283444135e9.12.2026.10.18.16.03.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 16:03:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] docs: Clarify 'query-kvm' deprecation release
Date: Mon, 19 Oct 2026 01:03:05 +0200
Message-ID: <20261018230305.6239-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA5MSBTYWx0ZWRfXzongZCMK4UJ4
 Qk0ZBbJur6JOJkFRebNnfxok2xE/EX1X8SD0JFnViFXyccIUtgi36vjjPAWNrQcbJc3+SHcF3Pe
 b+Q9Io0C4V/BOBkC8CrcHCCs4AftD58=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad5502d cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=uhKpQFyuRnTRNiYsaUQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA5MSBTYWx0ZWRfX5CjKdRx+iOVU
 Yad9rn1TeiSzIs/YimzfrqX7nbfsN8gEbi4vjE+dJdFtjPqgD1bnjdXCRGjGk2rVEZ+M9ENWNjn
 zXsnznZGjA/5R7xi7SW854H1MrTy8fvtWch2G2/Qc7pZDi1MlWUOP6Rvw5gT8VfAS7QGw9ktZWI
 IwI2qTSrpU/uBsxp/6lJztWNOgeQmt6TbMCIYJLclIqWWucQpQ+kaluyq4iNUPySuFDbSVun7aS
 W9GIqKFoW01jLj6czX7NygY3KR3OSNRGz3rmxLCEKs/P1a1K87giVHXoD9DX4Wl1tiEpJ69RnPt
 hoF5R7gjWJjQCjW8fCRHwns2cD9CpgG8OaLgRYW5LXDN7tfc/uzgw7AvIEPc47cPhSdlmB360SA
 kxHzUPQbEajg7G/eZOdvrmN3fMgwVoMj3mlKWS3OASwH1mYyzeSfDBCg8qMDiDrdY9HrGusEXvu
 zUyKPl72Xm5x6YnGk+Q==
X-Proofpoint-ORIG-GUID: 5hvoH8gdPpZs-jH6JWqtT8WosBNKhFnc
X-Proofpoint-GUID: 5hvoH8gdPpZs-jH6JWqtT8WosBNKhFnc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180091
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

'query-kvm' was deprecated in commit 824141dcf48, merged after
the v11.1.0 release. Correct to prevent too early removal.

Fixes: 824141dcf48 ("hw/core: Deprecate query-kvm")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/about/deprecated.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ccbc4219497..2507a86d1ee 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -168,7 +168,7 @@ Use ``job-dismiss`` instead.
 
 Use ``job-finalize`` instead.
 
-``query-kvm`` (since 11.0)
+``query-kvm`` (since 11.1)
 ''''''''''''''''''''''''''
 
 Use ``query-accelerators`` instead.
-- 
2.55.0


