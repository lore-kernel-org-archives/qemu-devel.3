Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5338DCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wST8h-0002LO-Ai; Thu, 28 May 2026 01:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7i-0001t2-2a
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7e-0003nq-Ve
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKlKcH2463182
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ENvm1iF+5Lv
 CUxFc8MW65vyiEQ9o3Dl/pzylCTFs5FQ=; b=CcCQ1gMTu8pdWo6WiyRkfvvczA0
 jfGAsAjayz8EYensLKgcFJ9T423WFoqq4yZwnwWBr2ELtkn1eQQO1twVosb+wfTE
 AOHTPBD37k3HZ2OTVwAIhqL8+PzjbKrOn9wRSWVmGl4frNMOPM/v5xXIr+4yuNeZ
 fyjn7CzzwU7nfl3z5Bcw+sd4xrzQLj5TQ7pn+/isxkJ5aINfxTuiV6V5313Jf8+4
 048AG8QRf+wdE8agjnZnhBVSqp20oOndZfE1vQys0bDisA3IzOjQOJl2XFDkDAnQ
 FTWzdNG1yK3wV/kAFw3Rdw0IsewattFLQ2mwS5HjhtLBiUeQpQpVdUYWhqg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y4sd60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30457ff05b8so5459454eec.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779945443; x=1780550243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENvm1iF+5LvCUxFc8MW65vyiEQ9o3Dl/pzylCTFs5FQ=;
 b=O7idHNgz2HigjfulXENcP9+uAEVKzBBYVEb38vZ3fmGWi2rXSuLGK00pcOecGUkJ/K
 ZzYpwSuKP13zs4EyCk9KS/Zkr5fQHw+x1jxR+dRbSc8drkOuHyUkJpSJbeWu+FYZ/ojn
 X0y46S9eHboY98x0C9bZKhg5502h0vn1kP3lViFX3dssRLlYcooD9/AwWlrq3B1eOwyc
 z0dpCGjStVqtEhq9PVkP/WVOZCBKgxBk6FNjqlACqR3xzk6R2oLtPckOoO6zRezNylce
 XSbBdjGOs/s63k9puoG14eU3bEU/DBgWVOPrj6TarwYiChyPEW/aaa/0JjAX9kKp5mNl
 dipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945443; x=1780550243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ENvm1iF+5LvCUxFc8MW65vyiEQ9o3Dl/pzylCTFs5FQ=;
 b=BuVhdqYOX7IKTGa7osRSnXneaV8DbFH5IY2ejCZwnKZt67mydTIY4eKGLJNOHBIl/B
 mwMjfuZw+ZfGSB+BfBZ2o+YMyOmCb/C6IcICA2y7tm3jk5+eM0Tas1NCOAvP2tUJwqBn
 lug/n0137JTjeMTG4dW4bWO3ARuqxXYDggHHkw4DTCyz0zm5MvNzjS5YKCwFlcMdmZS4
 n05rzYSLiegNe+3ahxLB2hlog9b3Pjcnqgeq+o9JcyMGP2ghqWpLQK0QCHez2TUId+0O
 iRYeZph3TnCvwtlwd9mTGrkpsjKxcVMsmPCpV0deeimOo/ymUEE1gys+t4gWJHjOHLUG
 vhjw==
X-Gm-Message-State: AOJu0YzSaMHiNCfw5pwJ28I24Vm84wwz33eVAhR8gNYWvJOIUH9VQauy
 JKHsgc/T0uwMtjZg1hsa3oNnrhGP6A3xzOD5oTlyv5q+nF9Vn1EKZyOat0zENlry9/NlytBX8P7
 yH/7BvyE4q2QN7h1XGGxDVT529xQCxxNbTWyCd6uicjEdfEcVD7PVQMBqWrd4crjOH7fH
X-Gm-Gg: Acq92OHXCkbO1w3DAQX9BM0bHDpqDlvVRZShhhlQGAIRUZ+pz1504UiZkeouleyV6D9
 79vsYqOPJ1LRAnGWnUyHBX8H/9Q73toRjMJ7e3iYjG0+wmQsf951mSCJunTMaTSIqnrfoRFu6yk
 EOHuib24xfiiSnaNutWCeddL4rFsWKTzvIQdGmrJt+9fkSyktbSRnQh8GLYj1OerprQ/qmRmzj2
 IpMqw33ldVVaz6DcwNsoze/FLdETWb/evhB+tZH5kjYJwwVG+dXu5VCtMI1b6JbShV293Rzyzlr
 3sUkRQuYjrVTsbn+V3WIrUgb4pC/mTWf0LyKsuoUCN9WdhnK0r9vXKy1YBmMlMZJY6jDSEMTiim
 QITHP40W5A/DkVp5RggIs/C3ok/esEeeOqG8pDOetrFCY+wlXfmI4sOa9nqaDPgsEuqGoM/RIM2
 iQ3wguvnBknriz8UuR
X-Received: by 2002:a05:7300:72c9:b0:304:997c:d4b6 with SMTP id
 5a478bee46e88-304997cdbdemr5762093eec.17.1779945442745; 
 Wed, 27 May 2026 22:17:22 -0700 (PDT)
X-Received: by 2002:a05:7300:72c9:b0:304:997c:d4b6 with SMTP id
 5a478bee46e88-304997cdbdemr5762032eec.17.1779945442091; 
 Wed, 27 May 2026 22:17:22 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304b984d9b5sm4094607eec.7.2026.05.27.22.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:17:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 08/10] net: use stub_ss for vhost-user-stub.c and
 vhost-vdpa-stub.c
Date: Thu, 28 May 2026 05:16:40 +0000
Message-ID: <20260528051642.115721-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0OSBTYWx0ZWRfX20aRsEOEEeqt
 Hd8966wNZYgONfxMNFiv2P2LbVp0O9MLznI0fD6KA8Usmln1PI8iWgjm12fwLrnQ2aglOKMWC4B
 cz/BF8PqxQ03gwj0M8/fh6iHnKEnqC+DVKBK/pFNcyElWDr9K77OpfplAAMGcAbEAdytPz7zVPe
 9e+Wm/WHyAsQiihitIpSxiH/R1kKwJtn1KfGY9iQmLK3YmLPnWS/9iPRrlQuk6pXBTZudcmN7XI
 N0zjTuMWyIXHpgCz9leJWZCZ2S6Aw/4toaoJMMWI0wsfKvII388NLy0czQArGhUcxvw+u3R6B1Q
 gHDnavX3S81gl5CR5F2CuSgU+5WjKi3BMmGejMaPg5u3a/1lDyUwMoGdk+0oYsCVXHYwV9K+Z2a
 lwMPrnDooojlLL++GJFC6GVkESW2Wlg1lOJ0bkkJBuw1CsNW6venvZ3biyVRYHZ2Pxewdcm+Fv5
 cEY3JpBYcargjePH4Mw==
X-Authority-Analysis: v=2.4 cv=feidDUQF c=1 sm=1 tr=0 ts=6a17cfe3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=rLAB-7AxZL2Av_YYLNYA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: oMP-QHW4FMhG8_uY3eZ3GCnOXQRvdFpW
X-Proofpoint-ORIG-GUID: oMP-QHW4FMhG8_uY3eZ3GCnOXQRvdFpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280049
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 net/meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/meson.build b/net/meson.build
index da6ea635e95..9c8068b06d1 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -46,8 +46,9 @@ endif
 system_ss.add(when: [libxdp, libbpf], if_true: files('af-xdp.c'))
 
 if have_vhost_net_user
-  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'), if_false: files('vhost-user-stub.c'))
+  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-user.c'))
 endif
+stub_ss.add(files('vhost-user-stub.c'))
 
 if host_os == 'windows'
   system_ss.add(files('tap-win32.c'))
@@ -61,8 +62,9 @@ else
   system_ss.add(files('tap.c', 'tap-stub.c'))
 endif
 if have_vhost_net_vdpa
-  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-vdpa.c'), if_false: files('vhost-vdpa-stub.c'))
+  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost-vdpa.c'))
 endif
+stub_ss.add(files('vhost-vdpa-stub.c'))
 
 vmnet_files = files(
   'vmnet-common.m',
-- 
2.47.3


