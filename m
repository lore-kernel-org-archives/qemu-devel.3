Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA91CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wST7Y-0001nN-85; Thu, 28 May 2026 01:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7V-0001jb-9m
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7S-0003mO-OW
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKlfWR124520
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MlYXm57XS0c
 N10pj8v6iy4d5pOPFTMD/0gjetLxA2Xs=; b=bgL08QeZ3GphX+Hcvgyhg7tghfn
 vCBR/bL9x7I+ZJxxoBx6J1iIqXW2tz+K6qaKhYkVLUXsj7T3xzJ4li3605PqkVTw
 KdL2S5EeUgEa2a9qOPw75nyualJjbQpAdcMX3q6oqPJd0B91inMoppDbfSBjNRsi
 3vPw2W7pXglBnn/odW+16vl5Cx0FHrmTF3lE/hVJtGkYjvHQjxVMeTzFq9eLNuDg
 +rX8wktlId8ltI7NSO3wTlFMor+q6MwFX4RrT5ferMUxf6SeBLrohOUIKYD1QcCD
 llpfjc0Wi8s6dX7BsjXGKn2xi07Nr+yzStjULJsKAfB1MXdTGXQ3ybcceVA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yahd8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:20 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1365060ac82so4742057c88.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779945440; x=1780550240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlYXm57XS0cN10pj8v6iy4d5pOPFTMD/0gjetLxA2Xs=;
 b=Anoejxzzb8UMLMWCM5FsysalWnPVwO78GJYRZMaXKJ4SlCGSxigUFNrWLxvE37bqH6
 K4yYSA7qlItavNxfYF7Ip5qqWv2igUIJY2Lhlmk+OibeQw1O5vSTQlU3jhP9XBZfeY/3
 2+gbxik5G1PCUdlW7Y1vLuX2bTgmIN2vHXiXWOB2AUBH7tgJ7F0VBK+rSumTHgfV3tZZ
 EjXk/3WBZWhFQuemNQFpdyKHEi+G8/3UFWOWIv3/PRA1oLVuC3Pppg9hgxakoNWCvvQT
 gH4jWxy7y1jTTN8nGCdktPGj/j/FAN8g/2EXev+tmzgwAnlF3Mrty+9sIoN5woOqExgA
 lGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945440; x=1780550240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MlYXm57XS0cN10pj8v6iy4d5pOPFTMD/0gjetLxA2Xs=;
 b=NijrdVSHGA33aOPApO834zOkaIRJ/F6DfkoUP6i1jDs9+VokRIzCB5yi4isxObiuqg
 wOjvAJVLyFAdfo1TvqFSPkm+bkQOtX6bs1GC6LDYT8wgwwe9XDzrGKaQHDZcSpmqdTgr
 sSKB1oDbIlsle914BGrRxjYhROZbds7p/w6h2lCF9QgNaR3l6yWMRg0mDNh4FEYDNcuS
 sbN71s8RAyMLsLEgORCO3bzgNG+7RbK6PFXL5Y2dzJEob7Bw6HPi1X1o78hJ4YLYe7KW
 C+/6UDiOFQ8IlQGeuTEZScvZGUARdqIQY6Tj5EQHg+wQFfuAo7iYyaLla8BB9DIjUyni
 Fqjg==
X-Gm-Message-State: AOJu0YxWzdy9kRFPvqgVuOgZRbJLHQihu2HtYjdl2uVl3XfyxufSnAsl
 OihRqd6mY0nnNXcAA3hP9quQbQVan5WjXzJlPSPPObPfhQBIKNCFDHoiY2FKpsR17UZu8VopgqE
 99iKDgdSFeAabrOgCKLph3f9HhTuhrNloE07tHvshZTRi1yP0psOCdpun02jje8iUtXKr
X-Gm-Gg: Acq92OHBsUzTTC5CClWkZGCaX1dtFPzsRNsN+Xm/Q2UDdfQnnFC1F8jviKhzY/04xYu
 khsh0YvDTXuq7+bix+SLojt4s8ZftlFAchdl6WhkkE0bI6Yd1dVjh5tEFkU0SDz3rMNerH5r6+f
 nO9OtOzbPmPUzepQADUVvB3NQiqJBLtNwAD2e35q1OLVMlpkYRFF/LtqQJOhbCHVpIYAkcHEbou
 iwMXUCAGYRaRYfkQ0H6p+9555kKPbNKEiNdsQJYekehvIKMychhvHZv4yYzGiTUprEIH8+EPzaR
 vMhKjRNcd4EzLHR4ya42BJaCJiSyOOhqoGolfCx3wBF6q7vioyO7S19H2dKehM0DAq6EVjgTOR6
 /YE9Qi+8WQxvUXX6YQGA+wGoc4DBMgas2fzm5HZwW8vAAQqQc+4ZzCFvmcpwYiKGwpqwAU3QYU9
 3/wOaRm+j261ZIJNth
X-Received: by 2002:a05:7022:497:b0:136:4bbe:9523 with SMTP id
 a92af1059eb24-1378e89e454mr37317c88.8.1779945439734; 
 Wed, 27 May 2026 22:17:19 -0700 (PDT)
X-Received: by 2002:a05:7022:497:b0:136:4bbe:9523 with SMTP id
 a92af1059eb24-1378e89e454mr37264c88.8.1779945439181; 
 Wed, 27 May 2026 22:17:19 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304b984d9b5sm4094607eec.7.2026.05.27.22.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:17:18 -0700 (PDT)
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
Subject: [PATCH 06/10] hw/net: use stub_ss for vhost_net-stub.c
Date: Thu, 28 May 2026 05:16:38 +0000
Message-ID: <20260528051642.115721-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EmwJlab8C-XnlWpk-vbNe26g8bf_Ocog
X-Proofpoint-GUID: EmwJlab8C-XnlWpk-vbNe26g8bf_Ocog
X-Authority-Analysis: v=2.4 cv=E/r9Y6dl c=1 sm=1 tr=0 ts=6a17cfe0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=rftao9l6T9mWZSOHg_8A:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0OSBTYWx0ZWRfX2/Ra49Fvperr
 Pb228YPV7xam6D0LM7ISUY03aOYwVZ3LgNFHzt8CHmv3i76TgMxuF2WN3k0PIUGEwFHWGWm/AoK
 6HqfofdId2R2zRw4Xcw9tD1iQW1Oy2yvSERfVqkXDs5TDZLGqKJRMOpwTZNVpFj6f/ATR70g5zi
 MrfVt/ukO5UeYMG50XPYxzNDIF+HHZtLYtz/BtAlY4UWa14Ng8A6xaH6H6tlMaTb81JDe0ohfx2
 JoBGZpmFSGxkieGlP4gXhNU7hR40drOz5sxIy8aJ+mLoW9i+e4AvQFxHoYeyGTIFp5RL44Lv1FP
 DEcwU1TXtkc6tweB+A0TxVfBlzcuq093uRZ/sOpLS1CLxl3CytkNRicdhkS71CHyKVhf8C+fsVX
 K5a8OhxU6xMfNE4Natb1lrvwOze2va5XaenV46NC3UdGlLVC01lPlrsy8n3MBI/I5QQEFuaHHh/
 SqbTWnEi98BFHF4xe+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280049
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Removes conflict with several targets where some support vhost, and some
don't.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/net/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/net/meson.build b/hw/net/meson.build
index 31025874699..84f142df222 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -48,10 +48,9 @@ system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('net_rx_pkt.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
 
 if have_vhost_net
-  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost_net.c'), if_false: files('vhost_net-stub.c'))
-else
-  system_ss.add(files('vhost_net-stub.c'))
+  system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost_net.c'))
 endif
+stub_ss.add(files('vhost_net-stub.c'))
 
 system_ss.add(when: 'CONFIG_ETSEC', if_true: files(
   'fsl_etsec/etsec.c',
-- 
2.47.3


