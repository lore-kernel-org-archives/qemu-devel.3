Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF49C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziO2-0005wZ-Ok; Thu, 27 Aug 2026 18:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNu-0005iS-P9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNs-00068I-Ja
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM2Ej3848482
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oLma5rA2yLbR0swPh7bAIAXRqc6qV0VXcf4yAANWjSs=; b=fcieX/36IRdVUpQv
 4XmlebxTWCVTMZV4VCWSONLcMS3jRCeRJhWnnrKwu335PGoQ1Io9AojkPVQ/GTTm
 HAqA5/M3JYug0LDbh7fX7311rVx/gjnnGusDbLAxIf19ZNA4hWHtlazHE+X7vflB
 46DlPMB2t/bwp3RWk6qM5ljOg+krfi60irwyynoK/kdN0J4vHcQpSmj2nFP/Krqq
 ojJqfsCMCW3tv9t/Usd2okSGcf8+s/1f0CxBcfDcBWZZIuFIlDuDr5Y1QJGx9qvU
 0K/jef/C8LPYVCSiHthfeKa+QugLoOGNYnPS6dpEiUZw/konakgZFm9iKkozvncU
 uiJmyw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0twe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84e4ef486c7so288985b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868943; x=1788473743; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oLma5rA2yLbR0swPh7bAIAXRqc6qV0VXcf4yAANWjSs=;
 b=j04n92jtSubQpkOD4S59GO1U/VTr+QPrBIlWmKaFwD2YWKz/J8hZGi9k/W6XxoLqC/
 m73MVPx7dfyW+ytJKxP/Y2SdJXsO4bP19fIoCiS5s6nSCKcSE39blgvvzP671ygP1wam
 WnYmnHCbF0qBmrI8GOtRstAX6oPDMKCQsi1R6bNnp5Y+T5jf65Rq8wZwyQCQMoRpuAlR
 Nq+MIciKuPRPBsrcu8xIQi6YQptzk83p4l6ZI6myGR2svmbcyL1wF81dOl02Vux9IT7r
 0yOaHvTsz0UU44mYgyBDgAwocREcK4eyAlaDfQ4XJ9Co8qhuT4nCqzkZUAeEHhLFXrfY
 vX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868943; x=1788473743;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oLma5rA2yLbR0swPh7bAIAXRqc6qV0VXcf4yAANWjSs=;
 b=cNLlSJuTSeYHCvGSuz7B3uIFzreH3gXQkvr/KtwHd93pPNB+MckpRZ66lpuf6rzyp3
 J34dRUR6wLHM+MDB5R5Sgfx41V0qzy2JDHPuAuTFkdhXWoVXRlosjIkMYXVoraldfnVl
 x42qVDi+K0rvoy5W8dAx3fVgSnDW3i+9w1Fi0s+QPnxXhxzArpf/I/VLiho4LO1bYqAH
 n6Wm5oLfVy2V/WTGDAereJuFQoG22NG3jYRJv5MMuHzijK65x2WXtCm+1hqCQmIGfKhB
 klZnCjZ5zJeK2GnhArCDge6g6Djos+hcRnh1U+S6CT+JgFqSRF5wO1p0xoZ2ZFuLx6aO
 DeGw==
X-Gm-Message-State: AFuF++mNZIAalOqwL4vGMONA7WneJ6NcR/NrrC37iZTQLJH+KEWMGUmk
 +81zOqCjpsBburkB+C8vj5iCW8QW5xupYdm8krtFZmaRlKtFTCbXiCIoQVDD3fb0yMKpQTiTLTh
 uVTgCTQbGkQAB0ssZtLvBFaYKw8WqJnpd7Jwes0RUE/EaTIiuZFISOPsl5YIK8IpX3Q==
X-Gm-Gg: AR+sD12L6AkVGjXPbm2RfXN0uxyXbT8TDqt/UXEhOFmFHbwrw4sdPtE9gaNlo5wkpvP
 oImeM/gFP4Clks07ER0wGrShu5NWD5CGPrceCf9jDF+v8xdKmOgbOUdggzCTKm/6X+Iy0mOspHd
 DgQjOHQ5IRhXPYi/0dIIpk1N1dLRuy7ZJKlDHcxbmRLYXH+gWyJpnhRKXOLqTDuGInpohvyyyAJ
 KcYH76AOT2RVtTcT0quT2iXcCoAwRIGMAKIdDD44syTYP4oD+Q7DApFEUC3xV2vgTa/Zzmdoq/r
 evYflgSWcRER45gKioiKlEfQQ4w/ma9MDA4086VvQqUIqFYQt9TRqhrxVfcv7LTr7RIFzAmJlSh
 Z6VwtcNxgAWaxB6Js77pEZxUznSC3GrWmsJvMqn9dk833xDMZpVJtqO+H/W0=
X-Received: by 2002:a05:6a00:1d89:b0:842:3c77:5996 with SMTP id
 d2e1a72fcca58-854c648573dmr13402632b3a.1.1787868942580; 
 Thu, 27 Aug 2026 15:15:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d89:b0:842:3c77:5996 with SMTP id
 d2e1a72fcca58-854c648573dmr13402580b3a.1.1787868942139; 
 Thu, 27 Aug 2026 15:15:42 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 027/105] tests/docker/docker.py: remove "Image is up to
 date" info
Date: Thu, 27 Aug 2026 22:13:48 +0000
Message-ID: <20260827221506.91574-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX8CHFtbOG3I/Q
 tiKBJIJVlUqntOeiTu8377HZlwpgP9cSBWUUVJtVTH3aIaNEy9DtEg3bf/MLbm7gZYc1clu4+tF
 cUsIG0eQ6jo+XrDoUZVluUklpNdGp4ki8zKKYU84433ZRn3va/lVitOnywzymUdytfLRib4Y0K1
 SOa1dhVK/F2yLuO4/SurkKinGsjcpkrqgrXumhVaV3400b5XEkeF0T7y3TzVRO+U2z2MlCik4PK
 mDNWT2xqmg6PXjlhNyTPh58eObmifRzVXeXksCTTLkM5uBjgl9qfcPtuBxPz2xPZbhcyHJSRylw
 cspEzIJLTa19eAR4UnLFg+51Jh2JGWFgxOdFPOZcSHKVKCoVEzlX7MAcdZOyOc4dM9RjoMVelkH
 vKQck8qXVJCvwgykTGdU7vzh7zZRNHXeciE2ui6gkQfGtzl//sG9ZRJ+08NYlx5DKFT41fDIknK
 h2LyBef8Z8bDSUZNbcQ==
X-Proofpoint-ORIG-GUID: 2IfByFkUIyHN3mPXDmI5zIfxS9SvvjxR
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b70f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=3L1wqYL7HJlRHUT7mJMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX29JulunsEweD
 c9yvriZNr7uc+z1HAjeDUAd31cNeDH6A4EH1o2P2IDRSspyInv+A6w0qAbpQcXiwmWiIbB3FGJZ
 X4i8Bz4DwHgXGyz2Bym3umpXFC/zTsg=
X-Proofpoint-GUID: 2IfByFkUIyHN3mPXDmI5zIfxS9SvvjxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

It's useful to print build output by default, but not useful to mention
it succeeded. Reduce verbosity of tcg tests build.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index fea6d0f85af..315fa2ff848 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -429,8 +429,7 @@ def run(self, args, argv):
         dkr = Docker(args.command)
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
-            if not args.quiet:
-                print("Image is up to date.")
+            pass
         else:
             # Create a docker context directory for the build
             docker_dir = tempfile.mkdtemp(prefix="docker_build")
-- 
2.43.0


