Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C99CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBuv-0006BE-Dk; Thu, 18 Jun 2026 08:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBur-00068a-2K
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBup-00019m-Gz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAsFQN1610627
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HO99xo4uoKyssNgfiyhu56HPbucqiArLONIifxdE1hc=; b=NN11ro5bhXLs0aY7
 vxygu2Gu4p93C4H8B2R30A86bDNJVQKe710Qu//ROltzqHBPnmCJXG5zXVK1Cjoa
 oHp9bW9n0/Yp6gC87GwthoxAlr+RuHBmNIqpCJnUN/RRjhtpNKGQGN/FwP7jLMQ+
 QryFkgNnW5H75FL1bA/Dsw2RMnsBp9SucyDAZrd5m9jv8nqQ9uFFpftq2IZqrRky
 8arI6dg48pGiQQrT7hkaNURGAsr41Bp5OsIZ/OoDdfCwxQrUWANisQ/or/pGdj02
 9R+yN0mB/iXdL0DJupe96tCZCGNjvcKvbSpjr/DZgOj+mh+zHL2AMUT+g1rJJOZw
 svuuKQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7kk31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:14 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4863a55600aso986674b6e.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785934; x=1782390734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HO99xo4uoKyssNgfiyhu56HPbucqiArLONIifxdE1hc=;
 b=Sg7sP9ijwc7fNxHfz9xDQLT8AO2UORjUwPWYCmnX+teo6hJBdntq5QmXitB69E3osC
 T4A4xNn5MVtWyhCP2Fu2vW6B4x08NJWavzlCX0lyNMomNjYWIJANb+T2rNvyR0AiPZ9k
 jpxAsxze54QutFhbQmRniKKjcmZpY4cAooZKQj5DsyA+BV2y6TDOUIP/PWD/8LoZIUYd
 U7Dd9QSJXW3ehSROZLLAoQ2HzmtwBEZ3IPQ/K6Pno2deSKGe3LTqMFNXis2kdDGIUhHY
 Jnd8ue+tK1jP8d400RyRAYIbp3Z24ImGs5B+bxUc7UgwLin8yPpJDUmexhHTKSBjNlc9
 DwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785934; x=1782390734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HO99xo4uoKyssNgfiyhu56HPbucqiArLONIifxdE1hc=;
 b=ontOUfCJarnU8wYg34V59xKC+sY5+KmXOvYlgOFoxo27GNkTfa4Ihoaq6kni8FhYue
 ri+vmXkTWKEENW73mwHG7a653FdVO1r9a+2bBY9aLvRWLiWPGh7JvGcSeXwlvKjbXDIE
 xi68NkkKjii813SSQmH7opRRfUs5FThVWu1nSPfJkDECloKdWr1tu9NnAtIZV9U4jYok
 SwwX7FnF0f2tNZSIDGjmEWhWFUhtK8PCdijg0x1tCRN6xjiuoRYILKyrNpvjTiKEMzCr
 8kNnGvrH5ld8kiiYeoq41k88891ntVqRUJKjzF5MZw96foF5UQqM+GpaPUROsW5UZB4H
 h8ZA==
X-Gm-Message-State: AOJu0YxMlUFOL9epAMdixyfplsiHrtnexbo727d1SfL8PA7SfylYpHrC
 9mA+LoceMcF+PvTzt3h5fSXyFMyiGWotrx4PY9vxogUb8xyW7qLc7+RCm8XyQxVzfSPYWlLDFJU
 8MfcwN2nDkVMlborLs/BN+6VuPmVZ9k+9cQot6XkYTgextQ7nI8JkMwgVSoI/bKszZA==
X-Gm-Gg: Acq92OEYH+0w0BnHGNcNTcmB6jIDHz6e5irfZ2hcFkTL5GS5Iks/obuUeymk0MQRsRX
 WzyhanVtJxqvtye/t5nW6w2VxVjwInq9IMRUnsUUfLTiQLRkANy+fGJqKLclkGaqG1yjJQEWpuj
 yhXYtshguz1+0RxULNjHcyMwG/qgysH8ghMW0ZywOGLIVM2aByeEX86aFxNI7Sv6Qd7zfkNof/u
 5ICakFd4beMDUIZmUhwxz1Dmzc9ljHCrJ1Bh2key/bscjltO3Sfq4sbRx0eftxFscdKBvMplTdj
 JJzO3IqOBcMLgy0Xkgt+uoBoW8h/O8ECtMkL94WRkDRw5RFsoyespVqt31yFHfb8eGcOqGoSn7B
 qKoXMg57dBqs23FInOTOnDf0UMGxHsc/p8Tclj00BVFF+UpaJuHFZozZByP9mxNQRG+Hu
X-Received: by 2002:a05:6808:1494:b0:487:4fea:2e76 with SMTP id
 5614622812f47-4895710c5fdmr2771383b6e.17.1781785933997; 
 Thu, 18 Jun 2026 05:32:13 -0700 (PDT)
X-Received: by 2002:a05:6808:1494:b0:487:4fea:2e76 with SMTP id
 5614622812f47-4895710c5fdmr2771351b6e.17.1781785933515; 
 Thu, 18 Jun 2026 05:32:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462e7fc53fasm11659684f8f.33.2026.06.18.05.32.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:32:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/48] configure: honor --extra-ldflags when forced to use
 objc_LINKER
Date: Thu, 18 Jun 2026 14:28:08 +0200
Message-ID: <20260618122825.90331-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXwOY6wejiFyj0
 op40lp9+NGlX0OAgf3O+x6X13niIh26s/iI3PfmwNAlpnqb8SVQkmTVHbrMT9hio9W4tA2QaWUN
 0jzXYvCcuVYYYw35GO44c7fKqwhAUciIo6+yzjYGd3xW/IW2yYJjxMIIXraTi0X2oEvdQOe8zpu
 A8z98RKPBZabYrF+BwiB5uEMFriXfLt1Mi3zqMBz7SY8aN/JyTvMpa4Sj634PfFqZqvHqRHfOHs
 iZRvGvETeIzYmgkcug18yC9P8qHhqYO5EpEfQDh+Ckx29TJ8g3KiRUb7nD+5XrhxT7bjYM7wKuo
 +mT0JzM09fhGZITBOdlVTTvXRcmcmjpk6amcnamyUCLgRMMPJe5N3IrHx7i1tYxy6fS6v7SbZ5n
 dCDK4mvIl4ooq59beWIml7nc7SVDjGzn9WZ5Ya7mXF7lnx/Sp9ZhnQSP25ZeX6tHl7EC4dqWpMt
 vn1eCNIcyea17D4HpuA==
X-Proofpoint-GUID: QHsVfQwttxRY4DRv7LP6EJ8wOs0r_HTh
X-Proofpoint-ORIG-GUID: QHsVfQwttxRY4DRv7LP6EJ8wOs0r_HTh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX52GIk/RLUD7m
 26Rvrgd3ig3HEbcKWtpB/R39ZELXKvxcgU/astQpXTKiNEHF6YV8Xhr6grZZsN7N+06Mj/j7QrM
 JoTMXTgddIpd0wr36kwebAaJLAe3/+Y=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33e54e cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=HHGDD-5mAAAA:8 a=EUspDBNiAAAA:8 a=d20Q7X4aRJljLOYRdwMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

From: Matt Jacobson <mhjacobson@me.com>

3220b38a8d had the side effect of making the individual target link steps
use objc_LINKER on macOS, because `coreaudio.m` became visible to Meson as
a source file.  (The preexisting presence of `cocoa.m` is masked by the
fact that it gets built into libsystem and then extracted back out as an
object file.)

`configure` correctly passes `$EXTRA_LDFLAGS` to the "C linker" and "C++
linker", but it neglected to do so for the "Objective-C linker".  Fix that.

Signed-off-by: Matt Jacobson <mhjacobson@me.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260615045547.23422-1-mhjacobson@me.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index d786d3a7c9b..d773c3c46a0 100755
--- a/configure
+++ b/configure
@@ -1849,6 +1849,7 @@ if test "$skip_meson" = no; then
   test -n "$objcc" && echo "objc_args = [$(meson_quote $OBJCFLAGS $EXTRA_OBJCFLAGS)]" >> $cross
   echo "c_link_args = [$(meson_quote $CFLAGS $LDFLAGS $EXTRA_CFLAGS $EXTRA_LDFLAGS)]" >> $cross
   echo "cpp_link_args = [$(meson_quote $CXXFLAGS $LDFLAGS $EXTRA_CXXFLAGS $EXTRA_LDFLAGS)]" >> $cross
+  test -n "$objcc" && echo "objc_link_args = [$(meson_quote $OBJCFLAGS $LDFLAGS $EXTRA_OBJCFLAGS $EXTRA_LDFLAGS)]" >> $cross
 
   # Only enable by default for git builds and on select OSes
   echo "# environment defaults, can still be overridden on " >> $cross
-- 
2.53.0


