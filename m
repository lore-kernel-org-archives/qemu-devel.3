Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD30FC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28er-0002c0-5u; Thu, 03 Sep 2026 10:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28el-0002bJ-Kq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28ej-0003wL-LG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1789266f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446585; x=1789051385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2vFRJLcL6aPrqHiaI4F6ESdUDOZETX+qnMa4e3jb3+A=;
 b=Jetqp35uoFC/H/dQ0MW0AJSbWAHSX6n6hhmr8S6Ug4+TFpkvhZf7cidpTh0uAGOZjE
 bSSCSPHrveFYScHrwUDbGpB5d/sE9LAZ/sq/3LiqVTRj5vkeiwsJB7iQTGn3EjnoRomf
 lBYCXM9pDthGNABwWtw0Y/mUXZtRg024X6gjWfswxC5dtytc7mJkSHZ+kLR57QF2DtEa
 lyxpgE+0aAq8G4I/xTlbJiCWWmt72q0+ekG2KsWUjJU3DvZ4osgFbsRcx73jF9DmOOnQ
 6WqTodBo2+wsHoMD966OOPNLc5TSq0v52n/Ns62EsG19Ynu8c0/0k3k58Fih6wOl/aM7
 M0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446585; x=1789051385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2vFRJLcL6aPrqHiaI4F6ESdUDOZETX+qnMa4e3jb3+A=;
 b=eXgV3sigK2FfgoZEgr9YMoMq0RPdm+5Vd4+37nQU1czYgilCy/8z9bafNsh94+evS7
 pr1i3ShVyThXh1XDMCL0y6nRu3mVusc+p0+RAndqrIWsJI+uvvWM0P0c/XgVrBtUjE2V
 5o/5gKv6J7s5BR8eNv6Aj35KXyBOga5stmbPNYLJVgfGa7XdKgB/qwwEzSXrw2jInfGT
 K18TXAOaJ64Zj77//E6F9E7u2qVpTP6/QzKMkxg8Vm9bY5cawdEdzzhDMZCK0x+8e9MY
 MZnmPQfIA3IaYvLxh9ZWaSO8UXRzKcs0r9z3Zyq0kBI205HMv9P5btRmk0KPhdf5Sz4w
 YfzQ==
X-Gm-Message-State: AFuF++n1onDQbJN9ajfOw80Ajf5fFtrEN1Hg80kkLC66Z2B1JAVp1O1j
 yeURqX7CdSKqKOgia3wXouYpzuiSUeekVqtS4KFokuIqHPiHIiX+WZ2FbEogHk5csWnm/2/fKnQ
 f4rJl
X-Gm-Gg: AYBFou1S9v5ROYVonar56IXefh01BKPRllsBmtxagv8PAS9sOxuccLbAAG0A/Y4rr2P
 CcvzvD5jkGpH32Feq9U9ntaraXA8jj3A3SgPZMNBV8lS1cT24dAa+xKS4rTCD2OqvoWwC787HJO
 dbPEY5XYECWVGu70osS/yG4zP1ZAGU2Ew5NiTWITy429ZcN/xo5ARHZ/+ysxw2MA28n4ByeMMVU
 NLbQuc852RNA0ktTvJdx3hFRI/9x8SLaYgandz+LnE6P0zigfduJcFXBv/HjmqhvqpCTy8ZNXsr
 sPYmayjnGTAo58CDoAjIHjSEqTs/0H0H+aR66NwPhmU5u247OFjpYz/iUxIp7JFVgMVPktsK1kB
 KVBNt/YOnlfzVqF9KQR/eEmd/r/BVtbNdzA6tctmUhsG4A1nB9oaIpWWxsQr+Tzbp5gBCDQHUEe
 mSEC4bO6kA1zQyWSUOeNGjYNdrdqt00MK0XU3MzKb/5QOPJGphCSqGPcQH
X-Received: by 2002:a05:6000:2892:b0:485:847f:fd7d with SMTP id
 ffacd0b85a97d-48584800086mr6555752f8f.24.1788446585471; 
 Thu, 03 Sep 2026 07:43:05 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:42:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 00/25] parallels: Add full dirty bitmap support
Date: Thu,  3 Sep 2026 16:41:18 +0200
Message-ID: <20260903144143.2328870-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=den@openvz.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Parallels format driver:
* make some preparation
* add dirty bitmap saving
* make dirty bitmap RW
* fix broken checks
* refactor leak check
* add parallels format support to several tests

Alexander left the team, so this comes from me. v6 was:

https://lore.kernel.org/qemu-devel/20260817185942.1065143-1-den@openvz.org/

and v5, his last one, was:

https://lore.kernel.org/qemu-devel/20240311181850.73013-1-alexander.ivanov@virtuozzo.com/

It does not apply to master on its own. It goes on top of "[PATCH 0/8]
parallels: fix Format Extension parsing":

https://lore.kernel.org/qemu-devel/20260811173857.396571-1-den@openvz.org/

whose patch 3 is merged as dc04053687 ("dirty-bitmap: fix integer
overflow in serialization coverage"). The other seven are unchanged and
still apply, so they are not resent. Together they sit on master at
a925240509 ("Merge tag 'block-pull-request' of
https://gitlab.com/stefanha/qemu into staging").

v7:
Rebased on master, which brought require_hmp=True into 15, 24 and 25.
12: Renamed a module scope variable which the test functions shadow.
17: Moved the read-only open case to 19, where the output it looks at
    exists for the first time. It could not pass here.
19: Reordered the QAPI additions and gave ImageInfoSpecificKind its
    @parallels line, both on Markus' review. Report a bitmap which
    can not be used as inconsistent, and cover that.
21, 22: Renamed the module scope variables which the test functions
    shadow, so that iotest 297 passes at every patch of the series.

v6:
Reworked, so the numbers have shifted.
2: Made it .bdrv_inactivate and armed the in use flag on activation.
3: New patch, inactivating a read-only node.
5: cluster_end is uint64_t.
6: Absorbed the mark_unused helper, fixed the used bitmap growth.
7: New patch, the check no longer dies on what it is meant to report.
9: Absorbed the three parallels_check_leak() patches and the truncation.
10: Dropped the redundant bdrv_pwrite_zeroes() of the reuse branch.
11: Refuse a bitmap which does not fit, report a lost one, added ext_end.
12: Absorbed "Make a loaded dirty bitmap persistent", drop a broken one.
13: Bound the search by the region rather than by the cluster.
14: New patch, the Format Extension against the leak check.
15: Skipped test_reopen_rw, the bitmap name is a UUID.
16: New patch, a bitmap L1 entry has to point inside the data area.
17: Mark the bitmaps inconsistent instead of skipping the load.
18: New patch, block-dirty-bitmap-remove reaches the image.
19: New patch, qemu-img info reports the bitmaps.
20: New patch, renames parallels-read-bitmap to parallels-bitmap.
21: New patch, covers storing a bitmap.
22: New patch, covers the qemu-img bitmap sub-commands.
23: New patch, covers a broken Format Extension and a combined repair.
25: Added a comment about the bitmap name.
Dropped "Preserve extensions cluster for non-transient extensions" and
"Reverse a conditional in parallels_check_leak()".

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

Alexander Ivanov (4):
  parallels: Set s->used_bmap to NULL in parallels_free_used_bitmap()
  parallels: Make mark_used() a global function
  parallels: Create used bitmap even if checks needed
  tests: Turned on 256, 299, 304 and block-status-cache for parallels
    format

Denis V. Lunev (21):
  parallels: split inactivation out and add the activation counterpart
  iotests: cover inactivating a read-only node
  parallels: Limit search in parallels_mark_used to the last marked
    cluster
  parallels: Move host clusters allocation to a separate function
  parallels: do not let the check die on what it is meant to report
  parallels: Drop unused clusters at the end of the image
  parallels: Remove unnecessary data_end field
  parallels: Add dirty bitmaps saving
  parallels: Let image extensions work in RW mode
  parallels: Handle L1 entries equal to one
  iotests: cover the Format Extension against the leak check
  iotests: run the persistent dirty bitmap test on parallels
  parallels: reject a bitmap L1 entry outside the data area
  parallels: do not trust the bitmaps of an image which was not closed
  parallels: implement removing a stored dirty bitmap
  parallels: report the stored dirty bitmaps in qemu-img info
  iotests: rename parallels-read-bitmap to parallels-bitmap
  iotests: cover storing a parallels dirty bitmap
  iotests: cover the qemu-img bitmap operations on parallels
  iotests: cover a broken Format Extension and a combined repair
  tests: Add parallels format support to image-fleecing

 block/parallels-ext.c                         | 437 +++++++++++++++-
 block/parallels.c                             | 455 +++++++++++------
 block/parallels.h                             |  23 +-
 qapi/block-core.json                          |  46 +-
 tests/qemu-iotests/165                        |  18 +-
 tests/qemu-iotests/256                        |   2 +-
 tests/qemu-iotests/299                        |   2 +-
 tests/qemu-iotests/304                        |   2 +-
 tests/qemu-iotests/tests/block-status-cache   |   2 +-
 tests/qemu-iotests/tests/image-fleecing       |  14 +-
 tests/qemu-iotests/tests/inactive-node-nbd    |  14 +
 .../qemu-iotests/tests/inactive-node-nbd.out  |   8 +
 tests/qemu-iotests/tests/parallels-bitmap     | 475 ++++++++++++++++++
 tests/qemu-iotests/tests/parallels-bitmap.out | 106 ++++
 tests/qemu-iotests/tests/parallels-checks     | 235 +++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 193 +++++++
 .../qemu-iotests/tests/parallels-read-bitmap  | 231 ---------
 .../tests/parallels-read-bitmap.out           |  39 --
 18 files changed, 1848 insertions(+), 454 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/parallels-bitmap
 create mode 100644 tests/qemu-iotests/tests/parallels-bitmap.out
 delete mode 100755 tests/qemu-iotests/tests/parallels-read-bitmap
 delete mode 100644 tests/qemu-iotests/tests/parallels-read-bitmap.out

-- 
2.53.0


