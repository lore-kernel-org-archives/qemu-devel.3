Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B568CC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 07:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6n2L-0001Kc-0A; Tue, 14 May 2024 03:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s6n2H-0001KK-Ha
 for qemu-devel@nongnu.org; Tue, 14 May 2024 03:57:22 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s6n2D-0004IK-EA
 for qemu-devel@nongnu.org; Tue, 14 May 2024 03:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715673437; x=1747209437;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=AnNgs82Yp+UDJCKhp2Oxhp2G3wEze/cPzmmbluUe1fs=;
 b=USYWO/9sGTi5eu5eTTJmF5oYTAnqRKTJrQvBS1gZHPYvfP2FGSjTI5tr
 58diIaELikGnY0CrqTJJ7lDY4wCCPFCmspSYOLlV5BIPsO67NpRveM9C7
 f5GVO53ieRqR83D8fP6YdV7mpl6tNAEsMkoxZQRv+8SGFd6HaKlCorqLa
 HwPKUeI4aC7HbNH82criCvIvGJDPKztsdyFOwnPaHjLc+WKW+5lvKEHsc
 ZRZ+hAf7WNWghRDeCBXLFNO+UBZYlh8Z7WTUOAD12qCV9KezBSaDyowsV
 BojVFAfIQgoRu5IKBYi8HgYmDzGu31+YXw8djPxlvc3sTwc9lL+Dm5QwV A==;
X-CSE-ConnectionGUID: 5rQOg+emQ0qXMGRLgk2wDw==
X-CSE-MsgGUID: akErDRMOSMW8C3utg5eHKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11813091"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11813091"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 00:57:05 -0700
X-CSE-ConnectionGUID: tKjFoLKfTNK5pXwfMxdxPQ==
X-CSE-MsgGUID: jMKWzqaeR0ifeUhEuFyLiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="35131349"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 14 May 2024 00:57:04 -0700
Date: Tue, 14 May 2024 16:12:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
Message-ID: <ZkMc5Y5DGhDlfB8J@intel.com>
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
 <CAJSP0QX0y_J1pu+hgUNhXn7bFJfoAMm9Ux9vq3u+k_UDjwK8Ww@mail.gmail.com>
 <ZjxKDkZjAitxCasH@intel.com>
 <20240509134712.GA515599@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509134712.GA515599@fedora.redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Stefan,

> QEMU uses clock_gettime(CLOCK_MONOTONIC) on Linux hosts. The man page
> says:
> 
>   All CLOCK_MONOTONIC variants guarantee that the time returned by
>   consecutive  calls  will  not go backwards, but successive calls
>   may—depending  on  the  architecture—return  identical  (not-in‐
>   creased) time values.
> 
> trace_record_start() calls clock_gettime(CLOCK_MONOTONIC) so trace events
> should have monotonically increasing timestamps.
> 
> I don't see a scenario where trace record A's timestamp is greater than
> trace record B's timestamp unless the clock is non-monotonic.
> 
> Which host CPU architecture and operating system are you running?

I tested on these 2 machines:
* CML (intel 10th) with Ubuntu 22.04 + kernel v6.5.0-28
* MTL (intel 14th) with Ubuntu 22.04.2 + kernel v6.9.0

> Please attach to the QEMU process with gdb and print out the value of
> the use_rt_clock variable or add a printf in init_get_clock(). The value
> should be 1.

Thanks, on both above machines, use_rt_clock is 1 and there're both
timestamp reversal issues with the following debug print:

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a366e551fb3..7657785c27dc 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -831,10 +831,17 @@ extern int use_rt_clock;

 static inline int64_t get_clock(void)
 {
+    static int64_t clock = 0;
     if (use_rt_clock) {
         struct timespec ts;
         clock_gettime(CLOCK_MONOTONIC, &ts);
-        return ts.tv_sec * 1000000000LL + ts.tv_nsec;
+        int64_t tmp = ts.tv_sec * 1000000000LL + ts.tv_nsec;
+        if (tmp <= clock) {
+            printf("get_clock: strange, clock: %ld, tmp: %ld\n", clock, tmp);
+        }
+        assert(tmp > clock);
+        clock = tmp;
+        return clock;
     } else {
         /* XXX: using gettimeofday leads to problems if the date
            changes, so it should be avoided. */
diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
index cc1326f72646..3bf06eb4a4ce 100644
--- a/util/qemu-timer-common.c
+++ b/util/qemu-timer-common.c
@@ -59,5 +59,6 @@ static void __attribute__((constructor)) init_get_clock(void)
         use_rt_clock = 1;
     }
     clock_start = get_clock();
+    printf("init_get_clock: use_rt_clock: %d\n", use_rt_clock);
 }
 #endif

---
The timestamp interval is very small, for example:
get_clock: strange, clock: 3302130503505, tmp: 3302130503503

or

get_clock: strange, clock: 2761577819846455, tmp: 2761577819846395

I also tried to use CLOCK_MONOTONIC_RAW, but there's still the reversal
issue.

Thanks,
Zhao


