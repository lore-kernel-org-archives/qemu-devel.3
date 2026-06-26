Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B647BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9u-000572-Vp; Fri, 26 Jun 2026 19:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9s-00051k-JN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9q-0004OQ-JQ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMwutV2098376
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kipZhX2recz
 WkMHt4IVL/SRVLjRRHGsxwZEcazP/7kg=; b=V8l/bkuUaM2EGjDcQWLBnxOpIgX
 JuYAWAHVTO505KpV64XuS5POoyuVfrMewA9C3oybCsYxO2kRUtyEkgt9zmK+ykdm
 +Asx2nZwXnXqxY20CAywA25k54OwWXIj6tZUzdmo1sOvSDrEiPogqPiH5hjZqNqK
 ptle99FZs35u0Usd50xE8U7i7IiXlDi2LZBNcxAHcvXqvVfQNjL64bfl9GvQP0wz
 LBS0gatS13qeF10hAq9+OZueUBMu54YSToFwAFTr1iPABFWG/IOFQeeQ93kN0iwy
 dw0LwpzQii7EYuwrXykocGEDysYNHT9GM6yjPh2yQdbgA4sDIplqldjsb4w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1xxvgtn0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso377577eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517214; x=1783122014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kipZhX2reczWkMHt4IVL/SRVLjRRHGsxwZEcazP/7kg=;
 b=KjgPgkukPQhZWlkhBo8SipnpcUMHszXhARIqDgHqxWO+9fteJ5Ls+VmTiZnP+w6WYr
 MVR9WxsXapstw5clGvVSYZyFvKlcLqEP4K/vkgJjLEHv6iD7foQLYGdmYhEzXaIT2and
 A1HhrXXREVKgaW74di7H5l6TBDfFFRH3F0HogpgGeWsx5BgdZ8M4K25o/zJy90bWIcee
 kDhoM3xWqqMMsrXgeHiliXjpaXIWY6X/5NFWWGm8JHlKQyxgTM1eNNTO8crpHEB6hQQ8
 HBrINP+H4xjcJB4QmnRnEKmVuYaHFzOQOGw19XURvlEt27wpAps4VnbCKWh5oX4aR73r
 Ze0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517214; x=1783122014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kipZhX2reczWkMHt4IVL/SRVLjRRHGsxwZEcazP/7kg=;
 b=WFpIunorDmLFR3IRZVqxDIu5AvwlIyU5g7nb33f3if/IURUeRI3kD/xy4tZg0GxLam
 mkF3Hip+3aWO1H7CrNL6dnRs7K5q2wDZvY7q7J87TTKaOlIAc1RJb4Mgm+7mZy1kFOcz
 S9ZmGsKTwa6K8G3KPFA/HsN1uxq6VD3amyDJI3VrIJrhD+4VduERgpDPDBoMzGkjxE06
 0aAmy8dBaSc2iAyPgFO3HRG47nHGjtrRWmjpmVOJUyUcXaewxJK2RpakTnG1/kfy73tj
 168IDGwcbigYtGszihJLZ4tYf8XzWzEFCD2vOGf0s7mpWSVWup0+xotakAuzFe10AQkW
 sZlQ==
X-Gm-Message-State: AOJu0YzBl1o9VN3H+fKlq9M9GKbNpntDoqlIAHtBZtrqIz8I486pgI1Q
 Nk116UAJ+BMPlofKALtECazqQaXEFZuCmHLavMr+hgltmQEgc5GAMqKBfVmeA4TMLPh8EM6fv5T
 g8G+oAnIEUjuY14y9KpsUvjn1VMYtJkGjECg2HDm+B2NGJ2Ke49mNDgkZrAN0PPmwoA==
X-Gm-Gg: AfdE7cl3nRab9ZJ1DTJqqArSNeNaQksrvzKHS5B1ybmdM398xFfOFC9AQob9jIuop89
 kG0TdzfGIcCPUmCNui+emzKlxs04qYEOShNYjzTPPd4dPkui+7bLlql1PUAWq8wIPlLUCuxRUJn
 YtFh7cfSBjxKz+mP6WOL1awwHJGhKGNQkwTUdVX2yF71IXl078r1gHHoyBYyxdLJng8Yjzf1rJ2
 WkeEOknT6ZxKGJF9E2zmWsArGgWQhrDvhUgU7+AWwAe/72PuNFBROgHpfHTdagiIo519W6DoBME
 TKOUz1Ag0Pq4yabXTGAWjoS5f5TOjY1jjc6JXKpYIaREWKRo9SAc7b97STJeOBHRHQZPeroasjS
 dkDdOfzO09a2QhRchb731hAic1I9LeG52VgOfBQFdnNKALQh3zKbiJ78tlbHAGNZ7Jzlq5HBvkZ
 OIHeaOIw==
X-Received: by 2002:a05:7301:fa04:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-30c84b64e8cmr7827187eec.10.1782517214289; 
 Fri, 26 Jun 2026 16:40:14 -0700 (PDT)
X-Received: by 2002:a05:7301:fa04:b0:2e2:4979:ec7 with SMTP id
 5a478bee46e88-30c84b64e8cmr7827155eec.10.1782517213817; 
 Fri, 26 Jun 2026 16:40:13 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 36/37] tests/tcg/aarch64: add container support
Date: Fri, 26 Jun 2026 16:39:17 -0700
Message-ID: <20260626233918.158740-37-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pVrnHojVxd49TErNDRieyPRV2bgV3sGh
X-Proofpoint-GUID: pVrnHojVxd49TErNDRieyPRV2bgV3sGh
X-Authority-Analysis: v=2.4 cv=BLyDalQG c=1 sm=1 tr=0 ts=6a3f0ddf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=-UYh4SIjE7vaOChai8cA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX9c8ySXbEJeak
 PyZh4jlIhPc9NibRUkbbOoP8SmolF7lpIeKMdzzddpI9dj6euBVei2Gn1HzKVk9OtJWsREAwEdb
 tbj96SRncH8ZuR0EuBBqBbb8pr1v6YEKxqIC3Q+lY89A17LIVFSSzEcDupqzCwNJuf7w93sylym
 7aknqbH0mPNqdPBCmccei3LNLe2KC3TOvW4obUiQALIbn/pzpF4eWYAVVcST2UjAdmk0m3lMzVl
 jwvbPGLPrvjPw74OQHQGojhCvSeKVvA85GWeCvI/n3aSu4fh3Xg2+bqlCktesON/XncDvPwGeKg
 ig6OmOMU7Wy3BIu4KZKdJRMzKYAv6kRK3y985MmZBigshmqwowzawoU5DazJUdR4BsStGSAR4c7
 fq91ehMchNy69u5Rh0KNGLMbAvV1iluHbis9m4ReolD45B4SM/zaT0oqBv+QjbkMUEUOEDhPFj1
 5VLZJbTO+CmTaEAlbpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXyHxENNolnnXj
 TqM5ZQhevWlVg3yyvTiIHbxbfI2JSCXIL3XVf9Z77M3v7fGkoK00YxNq6wBj1j7CwKZcKChTJRP
 rN6RvD3eF+0hHVxqrXyyC9YYxpiYlw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
 tests/tcg/aarch64/meson.build        | 2 ++
 tests/tcg/aarch64/system/meson.build | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 9baf98bc054..450cfb3eb81 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -1,4 +1,5 @@
 cc = 'aarch64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
 
 cc_feat_cflags = {
   'aes': '-march=armv8-a+aes',
@@ -181,6 +182,7 @@ tests += {
 tcg_tests += {
   'aarch64-linux-user': {
     'cc': cc,
+    'cc_dockerfile': cc_dockerfile,
     'cc_feat_cflags': cc_feat_cflags,
     'folder': 'aarch64',
     'gdb_arch': 'aarch64',
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 8242580bf6d..ad214a23a74 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -90,6 +90,7 @@ tests += {
 tcg_tests += {
   'aarch64-softmmu': {
     'cc': cc,
+    'cc_dockerfile': cc_dockerfile,
     'cc_feat_cflags': cc_feat_cflags,
     'folder': 'aarch64/system',
     'gdb_arch': 'aarch64',
-- 
2.47.3


