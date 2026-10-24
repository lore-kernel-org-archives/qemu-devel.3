Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372BD606A31E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y7DR+TXe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xz7+WNGE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKeg8-0000wR-Rs; Sat, 24 Oct 2026 12:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKeg7-0000wH-HA
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKeg5-0002Mp-4k
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:06 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExuNV1563068
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2/GHKJXdWhM24xSNJiGyoW
 CAkkkF3V0GVkAM9lRr3Pg=; b=Y7DR+TXeyvk0lEqi8Xe4O10T/XPT5BT/zz5eBy
 r1a+wZmszk5OAujIbbMkx8IhLsV9RfH0Q5Icx50/GllMUEBtLwD3KQLi7vUe8G5Q
 RJAAtDZT/0UW9Rtc6gM7qw7b/LEX20OiCH7rl9J6+ayB2LhMB+Aw5jLj95OV2Gw3
 tUWSOK1A5YWxPJNDr8TMNqZoiwpM5einDYrE9uBt0yQeRS3db2PZwno+FWfO0EEL
 JH3f51SCUA1UjXLzI21SNvfQmWqwuwT/m8e3u3neu+a47y6ZyoFGFxRbG3OKuKhD
 6siNZPkGCJpvcpIE9g4JvYO9T+6Np/AqOkQjRXLInDWaNtFA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0ghey9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac76132001so1429984a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859582; x=1793464382; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2/GHKJXdWhM24xSNJiGyoWCAkkkF3V0GVkAM9lRr3Pg=;
 b=Xz7+WNGEER/Ga2YkkgWn0SWSutZ/sOihKxN3Ep9fbYFKLNsHd3s87upUSgFqH02LdZ
 2pFqRQgb9DM+HHKV0dRpvSsUfaTRN6Bg3jWFAPclzYpj9WJI1qlvwan2iqW9cH0LdoKl
 uYccDh98HfSxj8lyRNfHYEZ/cKTWEUxlBzm2sblJhEzII1TjgsznNQvAQMRnM7uBUSkv
 wTN4qyrYORvlcl8oM2Z9+M4VkhOFDLBmO2Ik4xUu9Fv7jX6opeo3eoTXJ9cSAP+hImOi
 5dkaftkiobwGuWc3U7zs5AxahIGPbvFHLa/SsT2ZKrvs8S5dwsujDsniE9onshxbupvG
 VYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859582; x=1793464382;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2/GHKJXdWhM24xSNJiGyoWCAkkkF3V0GVkAM9lRr3Pg=;
 b=YdS3Gx4wsgAB63MZPvfPg3UuAIajYceMl7xY7ORZ8tZcGFFkWsi2rnqIHosfvqUcJ/
 9nVsSECnXrEQViMUpO22KOB8slQuOmqzidBL5d7OTJ2sy2BI+RP21flIRcKTn+RsBGYU
 1T+N0aWeTkvBSOrYKBcBV4aNB3VKwIWIRlMtgn4XskIkOzlYP+rw1QSHFoET0nAw2Vf0
 QQwKG5Xz/6xU4hILdpUwiPh9M1gJzTuGEc3zKimCnTvxGLG0yH7z6CMHedN3Hi1Ogfnf
 T1URC3fKm53vPZDZ3FzVwACElyFCpbrMZKlKdTCMq2vvMNSpCxbdFmn+BHsuici8Y0kp
 bojw==
X-Gm-Message-State: AFq9FYIKJjgZlKXgoNlkgNpQkyF/2yTbNK3SERKEfhEraHuAc9lxQxy2
 6QgcMiLXIgF470b8Xb3zxYiqpuqtwPFd4R+sRonV5KY1BomZFHrhKQnHMS7AADUjlQXAIcdL5OQ
 OGRqRmp3HytXSIX4eqWWegROq9eRJ24f0CYaWcW+w68GD9vfkeqFfJPpkvg1FRgZTcg==
X-Gm-Gg: AYBFou0Vm49DEHydPPF09ylCFvHI0NNecxtjprI0gO82gW4FENJol+S9TWmLQ9nR7gn
 glqMFeCjur6Sa+2zFdIjz2b30oFmP7PYR5mGz8vWyD3zb0KqdxfVZAbDsBnONFZaEQtETMBcyAH
 7eXleBV1oTwhpwh+itiVHaSZ3ZFNz/S3iTI4AC8fsVonXIMAJ/G7HsmVFAZlaHJP6u5kty1/bbQ
 eNWTJBQkWQhiAPtxlGOpHZXJ2LrjHnv9xdO4LZ6xATXPpqz7pqwUeO/OBfMVPFR4OHByRYohR4b
 TorxCZf54xv0GRUfpy22kSTs5fwNB0iegukzbJWpqVf/79sie5NljMNW+2oVXJ+S5tM8O6ISVUb
 KzyD+R0L+Rx3jJd0uSlefsP6hcbBxgbrt0Rpi5DJm2OkAJjuZjTB0x2tgAn8SZpc=
X-Received: by 2002:a17:90b:2b4f:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ade952f931mr1911128a91.0.1792859581673; 
 Sat, 24 Oct 2026 09:33:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4f:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3ade952f931mr1911119a91.0.1792859581234; 
 Sat, 24 Oct 2026 09:33:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:32:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 00/11] multi-target: prefix helpers with target prefix
Date: Sat, 24 Oct 2026 16:32:38 +0000
Message-ID: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: l65U3WAXuG7cTsMaauBp8OGkG0HyVv4t
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adcddbe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=TiOetBcVxDZ8AJuDSRwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: l65U3WAXuG7cTsMaauBp8OGkG0HyVv4t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX8kQL89f3HwFi
 OyWnMKZBXfnrhOr0KHEbHlyBAmVH91TUBiDTzwyH18kOGTxMzJ2EkOfOikcfU3J4aVFas0mh0TJ
 M8ora8BQ+luA6d+ojcpohqG0R0dCmMq2i9xx8/ZeFNuqM1XI4Saz+99TnPL+FlFamJBPZgIkzeN
 eIYkHd60oxqg2mZ7n84eICyBkq1/CwISDRdPdjP67qx5Lsw80GfmwhY2iVmOFzQfc+FDyu4LgTG
 TWZpc+6dRUxLYTwZYFHRSQR9iEQvKUaCne5WcLXFh18/1KB5eCkt2+oqn3dUvEIFjnlUMTve69v
 +y0Me7S0S4kl8Q13YK6T+iVHZ3l7acygMjjRJ+zDyBxCI8smusvaWD/j2wg7BuOnu+3xJfvpVvY
 WiKkxeD74qQiI0W3eRzs7N1OSLBvVCsjxsb+vDXmjef0b+doIcN0ClWWkMCrZQhP9K4XixXeBLy
 9iOqVGRwmy7Meo2ceBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX7dQUB9Mz2ahg
 BHvZw5hLC5J8fVlzETU3qSU1W0syPgSUK4ygNobZCW5UrIRfXLaqlTLAn2/pcaOsbJoKsJYp9JL
 zQrIqDf3j53KdxYSd1oHuWPR2IULNX8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240065
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When linking multiple targets together, we usually have conflicts with helper
names. So far, it was solved using ad-hoc renaming, but multiple people pointed it
would be better to have a general mechanism for it, so here it is.

A previous series attempted that:
https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gmail.com/,
but it was relying on (binary) symbol renaming, which is not a portable solution.
Instead, this series approaches the problem from source code directly.
It requires more change, but it's cleaner IMHO.

Series follows these steps:

First, we make sure all helpers and definition are using HELPER() macro. A lot
of helpers were already defined this way, we just make sure it's exhaustive.
After that we don't have any 'helper_' left on any target code. This is a big
change touching the whole codebase, but it's a simple mechanical change. As long
as it compiles and links, we know it's correct.

Then, we introduce the prefix for target helpers. For this , we add a new define
(from meson) that applies to all target related code. It could later be used to
prefix other symbols also, that's why it's not named "TCG".

Finally, we cleanup the previous manual helpers prefix that were added in
codebase.

v2
--

- rebase on master (series partially merged + solved conflicts)
- new sparc helpers not using HELPER macro

Pierrick Bouvier (11):
  target/rx: define and call helpers using HELPER macro
  tcg: introduce HELPER_INFO macro
  target/sparc: define crypto helpers using HELPER macro
  tcg: prefix helpers with target base architecture
  target/alpha: remove explicit target specific prefix
  target/hexagon: remove explicit target specific prefix
  target/hppa: remove explicit target specific prefix
  target/microblaze: remove explicit target specific prefix
  target/or1k: remove explicit target specific prefix
  target/rx: remove explicit target specific prefix
  target/tricore: remove explicit target specific prefix

 include/exec/helper-gen-common.h   |  7 ++++
 include/exec/helper-gen.h.inc      | 48 ++++++++++++------------
 include/exec/helper-head.h.inc     |  8 +++-
 include/exec/helper-info.c.inc     | 16 ++++----
 include/exec/helper-proto-common.h |  7 ++++
 meson.build                        |  2 +
 target/alpha/fpu_helper.c          |  2 +-
 target/alpha/helper.h              |  2 +-
 target/alpha/translate.c           |  4 +-
 target/hexagon/gen_tcg.h           |  2 +-
 target/hexagon/gen_tcg_sys.h       |  2 +-
 target/hexagon/helper.h            |  4 +-
 target/hexagon/op_helper.c         |  4 +-
 target/hexagon/translate.c         |  4 +-
 target/hppa/helper.h               |  6 +--
 target/hppa/op_helper.c            |  4 +-
 target/hppa/sys_helper.c           |  8 ++--
 target/hppa/translate.c            |  6 +--
 target/microblaze/helper.h         | 10 ++---
 target/microblaze/op_helper.c      | 10 ++---
 target/microblaze/translate.c      | 10 ++---
 target/or1k/helper.h               |  2 +-
 target/or1k/interrupt_helper.c     |  2 +-
 target/or1k/translate.c            |  2 +-
 target/rx/helper.h                 | 12 +++---
 target/rx/op_helper.c              | 60 +++++++++++++++---------------
 target/rx/translate.c              | 14 +++----
 target/sparc/crypto_helper.c       | 30 +++++++--------
 target/tricore/fpu_helper.c        | 12 +++---
 target/tricore/helper.h            | 14 +++----
 target/tricore/translate.c         | 14 +++----
 31 files changed, 175 insertions(+), 153 deletions(-)

-- 
2.43.0


