Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF6BC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFp-0007FH-Tl; Thu, 27 Aug 2026 18:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFn-0007EJ-G9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFl-0003GB-KL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLuCS547180
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jXEfn8HU1bsl+jhD9MjbjXqtYGzSg0NykruK6LyfA3g=; b=AYrTN6EnmW1B9fcz
 ITYxRIyjAXJvBftrJ/VqdPschjXEvbxAv7hd0W4xOPdInm1TiJNAGvH0oPgWo4PY
 eQZJsCEnilqRYbdPCRI2r0zJzQPGTA/olM7321fQoTepBNBL2v4TGbr2XZb3ciWG
 c7PFLcD/BclhrsZeXnu5Fk6Telb2OA37/ya1iGmmjxOMg+5SWk90oclswBNKi6Km
 RlWPmRft+kvvsSOh2ZQleRtDeTGbdW06sYHuexY6veBjGwsL5DGMpqvUb4dCeV8V
 BNVx8sDVVt60cH0GAL1BXODoF+PYTeDr5F58G91p5DQMvEdpzbXpZQKIXMh2tL/j
 7XfI0Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak562snj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84859a64079so604352b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868430; x=1788473230; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jXEfn8HU1bsl+jhD9MjbjXqtYGzSg0NykruK6LyfA3g=;
 b=eQG4FLf39rJsktks7a6i3yG+nemQNVvdV9Np2atYM59XRL1sAC5T+4g1CjtwuXj+f8
 tpe3o8ZR7V1nsb6GY2D9cavqV+pmorlVj13QgABtBNW2qqWZCYKYhPGytCSteLrraoGF
 d9zI47+Ba5Sd7BfoAQHRS6licv5pmiOsGj3aAEsaMZn9ykCUs01Cuko4Hpc/M52QtizT
 9MbJMbBo18fWBrZnXkBkl0g3TjHf/ni46RlMCFd/PhnE2nCu5ThbCrduhsUnCACGvAWs
 +AwUm4KQwTpeR/lMex3AXW+2/Uj8YNlWcohr3zt8aHIBFnXCLXQZZLSAov6CURBt67nj
 iRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868430; x=1788473230;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jXEfn8HU1bsl+jhD9MjbjXqtYGzSg0NykruK6LyfA3g=;
 b=YGYMWEFUzYLojgWEoZH4pUj4I7xmGRkbYh8lmn5utcfKN2TWBY1Z6sewIZdzePlJ5I
 i0pPHdXEfHND6f4E/y+UUGuzCO3nW55f8R5QVgqiQdEQCTXirkxPoY3o85Pdpc0EtSo0
 By1tSYIOIKwyQD80D9LqMdMKLwQzeYRfvds3KlRvFJHLSn/gKZ/XAg/qDFv819m3o5BG
 XfyszkGOOjnc8JFGlHAdP3Kgr2n0Vgn0/pkeqlJfHhtNzYWQaonFet8hroW2NgbOPqbj
 17kChqN2531FW6Phh9npuLSrsACOCpfkK1/AdYMQNSCDB6l8quvcsEi58sUDd5Jnwnw0
 t3rA==
X-Gm-Message-State: AFuF++lsz9bO8lF0tFQqUBB9542oEkdWurht6qICNvnSUo4ntXo4JWnH
 fco3rHAbXvc01JDTj9rqthhVuvZ0zIxIBGgw6fh+HHgbEvvEQpLDxQbI3wX1YxGgXAtPWaPwrjh
 uTi+Hvidh9ECjW6D3jTphnd0FywN3ZaGhwP3uqKYr727ztlWK69qWU8tHsluk3J6Yaw==
X-Gm-Gg: AR+sD123czc+1QzcNHxwZjo7hcupsk4GT/d+PuDFzxHF3updsC/K2UfvmQjA/nmnVfb
 FO2Hgp7xuIsW8NBFDO2PSDBfJfBwDoMfNw2kJmzSrHnSpLecgHIix8A7HrNmHE6rQqFaUkoktC6
 Bx87xlGaFD526F6ArUjWbqEXLxe1iNeuLL4gdlLus2wHDrrRAg0cwJO9FqLVLDWdxAZxE98RStD
 34v7zdQAAi9fX+hehKUuImiEdkmiuLMlNfAUR1A+Dx0h7J8In5MEd/ZhuHtpuil6ot80r88fTRN
 crsBAqPQZ6g6eGqNDbBK3h+pyfkJcpSAMeqbU+Pw3pe/kWwGAXlIGeMrdb2L24Si6ncZ+2Bs8O7
 4Q2io/a+HX8NS4+1KpILMRTKv7L7e7mubyugTJlqUGHEDXXHRliXrSe9jY70=
X-Received: by 2002:a05:6a00:3d13:b0:846:bc60:5bf7 with SMTP id
 d2e1a72fcca58-8562868f32dmr4665962b3a.6.1787868429682; 
 Thu, 27 Aug 2026 15:07:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d13:b0:846:bc60:5bf7 with SMTP id
 d2e1a72fcca58-8562868f32dmr4665859b3a.6.1787868429288; 
 Thu, 27 Aug 2026 15:07:09 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 015/105] tests/tcg/meson.build: introduce wrapper
Date: Thu, 27 Aug 2026 22:05:09 +0000
Message-ID: <20260827220641.84885-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX0U7WQJ//HB+e
 lrUv7cnHJ8JQFuVQo7bpWC2KGj3YrJsrlxdDqP9dqY6EVfU67ZE76OoMsJWR4Z0dAbGUU23e/09
 p+zuTx0wxTnbT1+jwzyNUng+FhEuOBU=
X-Proofpoint-ORIG-GUID: SNNNvxpZAVyg8bEevfjqFzpriIEUH2a_
X-Proofpoint-GUID: SNNNvxpZAVyg8bEevfjqFzpriIEUH2a_
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90b50e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX4XJhE55bdxnX
 50uTQpqDNS+RsKcVhs/MM6EaBRUPhvowtjHveatci7hngyMK1lrJBqi7+0dc7my0CWfka3mAbCr
 RAPTaSVYp2gpVxJeFUA9iflGClaz2/5+v0UAlP6GGbYYef3Y0KnBE9g+Wf8+CbsKTYrihBGykYD
 AdciHamPNDJSiiRtsJIOtw7CexC2YUeNsim0z27tOKmGTY4ukhwSxfH+lH6/VnadindDXfwxmdc
 +9WvwewuXcYbWSCHoSMk+X5nkADoQWOsrhNj5meqAj6a7u+BR76PhRg2eFc3uqfaghSrvErarxI
 l0OQsMHg5WOw2FhJIMODSe/dBqBsvX+eVid8VqKi8nrq/CpIFXbSMq22sbRd+B65B5qJzIVvMKj
 5EvflQ5hp6ySejdD4QQnbH90tM95z9rWOFro6zKSIFkgXHPJO6zjX0UGR/F/7Thj1c0v5GHOhlz
 QG5WGCkAy14jeAox6dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76375615d0b..0311b2432e4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -25,6 +25,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
+#           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
 #             'args': ['plugin_args', ...],
@@ -86,7 +87,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name']
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -200,6 +201,10 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'wrapper' in setup
+        cmd = [setup['wrapper'], cmd]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.43.0


