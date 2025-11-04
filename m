Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE85CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLfn-0003BE-Ng; Tue, 04 Nov 2025 13:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vGLfe-00037X-Vj
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 13:22:21 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vGLfa-0001fE-Op
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 13:22:18 -0500
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 114397A0145;
 Tue,  4 Nov 2025 13:22:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 04 Nov 2025 13:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1762280531; x=1762366931; bh=i4dlNCEJYOUnjt+4MKQnKUo6HzywZ0fV
 Z7VYf2jCh7g=; b=CbdHqNP7n2t05xPEK32nSHsW9FxbuXGvguU79PFrM77leS7q
 bpvbmOzfkXKcF5O3VZeegOZAJPsdSgSu3r1ALquR9j9mqyDNuTv5jnZezkChpvYu
 aE5Ot7qaw/vxq0fKI7STxSRphBQWU1l7tWgB/FsLIhwCUMI/zmOyAFme61E8I7Pd
 yt/3F+sdgiI3bmROMJDCRv+EG8LSZUnlP+Jybd5mTZEC8V88uUQvh4zj7ykpCDyi
 2qLBc2rGN4E4/VskuUWwiTOEMeFf4r27qFoazlKq2CUJp7HeFpBAXHV2A+08j5Cf
 BwNUxUhpYQM5pMbapz+QWhi9/KwzLSobnuHR1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762280531; x=
 1762366931; bh=i4dlNCEJYOUnjt+4MKQnKUo6HzywZ0fVZ7VYf2jCh7g=; b=L
 fFIehND/M+JKxxnehVCqEo3Bg7+7bMIlFq92XQCR9F6rzfqhAY5duh25M34hO0tf
 ryM8v/cqiPvnD2pkiDqyZQnKvged7AOtG/4EuHRYip9KRiREnsYgYmAlzCJqlFYG
 2pb+Sv2oJ5gp9HaVCqXWQuqFJWtW9jKrokWuY33JaDRlIPfcG5iJaWXm4+cXdcEq
 BBq9HQJLCDnmnslerMOm/LFd1FIqaspTfN+Z2Zq+IQA5pMhek7u3AC3UA63kWUw1
 WOYC7xF0ywm7TFXuC87bEmTXVZA/m0yPMmBq/1SCOMqYy1LbMiPDAV78icZ8cQ9A
 QZK8bUB+dBx63YKeojQlg==
X-ME-Sender: <xms:UkQKaY10YWd-aFKL84He_yTued_KKqBIb6mYVoeSPVCrlKYf-1udXw>
 <xme:UkQKaahFA_0u9PNI3xcUGiatowrko0GY7TQsKAGWHloaTS0euYB94BosiG2C-kJA3
 eDXf94BbLB5f6tsoOZQ-7k8Nto3jFQ25jNLFcpcg21AAEq6JecQmQ>
X-ME-Received: <xmr:UkQKaeSgV8aajNv3NVExN1V3x4_Wo66QETt5slDLOjygqb4jG51bkuNsp9tZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedujedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhs
 khhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:UkQKabjc1iDxf450sfADHYbWTYrqhx8kLd-mSmE9IwaZKJof-sPNMw>
 <xmx:UkQKae7FynmlJf5OHQXCen5hwokJSWsEaL0Ns8piG3dfv0O5CjzmDA>
 <xmx:UkQKaYCbI-8BWTLYoNgFw8u0vOIANwQCFw1Cfr0WmjZltqugil1E9Q>
 <xmx:UkQKaVY_sZd7UzxPBgH3mxd2cDqsp_3d2HWFRSSaKP49s7LzC1CDLw>
 <xmx:U0QKaSP8F-4xcJ8rOmdrE7qfE55sZK4wO5UCkUd_tApV3ViJr7QHjae9>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 13:22:10 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 976429cc;
 Tue, 4 Nov 2025 18:22:08 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 13:22:08 -0500
Message-Id: <DE04B6ML0Y88.RDY01MRGCG8P@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/7] ati-vga: Add scissor clipping register support
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-2-chad@jablonski.xyz>
 <6e18e36d-fbaf-2f51-949a-666d48f14628@eik.bme.hu>
In-Reply-To: <6e18e36d-fbaf-2f51-949a-666d48f14628@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.157; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

>> +        if ((data & GMC_SRC_CLIPPING_MASK) =3D=3D GMC_SRC_CLIP_DEFAULT)=
 {
>> +            s->regs.src_sc_bottom_right =3D s->regs.default_sc_bottom_r=
ight;
>> +        }
>> +        if ((data & GMC_DST_CLIPPING_MASK) =3D=3D GMC_DST_CLIP_DEFAULT)=
 {
>> +            s->regs.sc_top_left =3D 0;
>> +            s->regs.sc_bottom_right =3D s->regs.default_sc_bottom_right=
;
>> +        }
>
> Or is this what you meant by style? Now I get that. I think the bits=20
> should not reset the regs just cause the operation to use the default=20
> values instead but if you can verify what actual hardware does that would=
=20
> be best.

Hi BALATON,

I've tested this on the real 'Rage 128 Pro Ultra TF' and it shows that this=
 is
the correct behavior (copying to the registers). I was definitely a bit
surprised!

I've run this test both with X running (idle over ssh) and prior to
starting X with the same results. I would like to write a bare-metal test
to make sure that the environment is a bit more controlled. But I struggled
with modesetting and it was looking like it was going to become a bit of a
rabbit hole. So I settled on testing under Linux for now and left that for
another day.

Here is the output:

Test SRC clipping
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

** Initializing DEFAULT_SC_BOTTOM_RIGHT to 0x0 **
** Initializing SRC_SC_BOTTOM to 0x0 **
** Initializing SRC_SC_RIGHT to 0x0 **

Initial State
------------------------------------
DEFAULT_GUI_MASTER_CNTL: 0x4a1de00f
DEFAULT_SC_BOTTOM_RIGHT: 0x00000000
SRC_SC_BOTTOM:           0x00000000
SRC_SC_RIGHT:            0x00000000

** Setting DEFAULT_SC_BOTTOM_RIGHT to 0x0aaa0bbb **
** Setting SRC_SC_BOTTOM to 0x111 **
** Setting SRC_SC_RIGHT to 0x222 **

State After Setting
------------------------------------
DEFAULT_GUI_MASTER_CNTL: 0x4a1de00f
DEFAULT_SC_BOTTOM_RIGHT: 0x0aaa0bbb
SRC_SC_BOTTOM:           0x00000111
SRC_SC_RIGHT:            0x00000222

** Setting GMC_SRC_CLIPPING to default **

State After Setting Default
------------------------------------
DEFAULT_GUI_MASTER_CNTL: 0x4a1de00b
DEFAULT_SC_BOTTOM_RIGHT: 0x0aaa0bbb
SRC_SC_BOTTOM:           0x00000aaa  <=3D=3D=3D=3D=3D=3D=3D Set to default
SRC_SC_RIGHT:            0x00000bbb  <=3D=3D=3D=3D=3D=3D=3D Set to default

** Setting GMC_SRC_CLIPPING to leave alone **

State After Setting Leave Alone
------------------------------------
DEFAULT_GUI_MASTER_CNTL: 0x4a1de00f
DEFAULT_SC_BOTTOM_RIGHT: 0x0aaa0bbb
SRC_SC_BOTTOM:           0x00000aaa  <=3D=3D=3D=3D=3D=3D=3D STILL default
SRC_SC_RIGHT:            0x00000bbb  <=3D=3D=3D=3D=3D=3D=3D STILL default

Test DST clipping
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

** Initializing DEFAULT_SC_BOTTOM_RIGHT to 0x0 **
** Initializing SC_BOTTOM to 0x0 **
** Initializing SC_RIGHT to 0x0 **
** Initializing SC_TOP to 0x0 **
** Initializing SC_LEFT to 0x0 **

Initial State
------------------------------------
DEFAULT_GUI_MASTER_CNTL: 0x4a1de00f
DEFAULT_SC_BOTTOM_RIGHT: 0x00000000
SC_BOTTOM:               0x00000000
SC_RIGHT:                0x00000000
SC_TOP:                  0x00000000
SC_LEFT:                 0x00000000

** Setting DEFAULT_SC_BOTTOM_RIGHT to 0x0aaa0bbb **
** Setting SC_BOTTOM to 0x111 **
** Setting SC_RIGHT to 0x222 **
** SETTING SC_TOP to 0x333 **
** SETTING SC_LEFT to 0x444 **

State After Setting
------------------------------------
DEFAULT_GUI_MASTER_CNTL: 0x4a1de00f
DEFAULT_SC_BOTTOM_RIGHT: 0x0aaa0bbb
SC_BOTTOM:               0x00000111
SC_RIGHT:                0x00000222
SC_TOP:                  0x00000333
SC_LEFT:                 0x00000444

** Setting GMC_DST_CLIPPING to default **

State After Setting Default
------------------------------------
DEFAULT_GUI_MASTER_CNTL: 0x4a1de007
DEFAULT_SC_BOTTOM_RIGHT: 0x0aaa0bbb
SC_BOTTOM:               0x00000aaa  <=3D=3D=3D=3D=3D=3D=3D Set to default
SC_RIGHT:                0x00000bbb  <=3D=3D=3D=3D=3D=3D=3D Set to default
SC_TOP:                  0x00000000  <=3D=3D=3D=3D=3D=3D=3D Set to default
SC_LEFT:                 0x00000000  <=3D=3D=3D=3D=3D=3D=3D Set to default

** Setting GMC_DST_CLIPPING to leave alone **

State After Setting Leave Alone
------------------------------------
DEFAULT_GUI_MASTER_CNTL: 0x4a1de00f
DEFAULT_SC_BOTTOM_RIGHT: 0x0aaa0bbb
SC_BOTTOM:               0x00000aaa  <=3D=3D=3D=3D=3D=3D=3D STILL default
SC_RIGHT:                0x00000bbb  <=3D=3D=3D=3D=3D=3D=3D STILL default
SC_TOP:                  0x00000000  <=3D=3D=3D=3D=3D=3D=3D STILL default
SC_LEFT:                 0x00000000  <=3D=3D=3D=3D=3D=3D=3D STILL default


And the source:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

/*
 * ATI Rage 128 Pro Clipping Mode Hardware Test
 *
 * Tests whether clipping mode bits exhibit latching or dynamic behavior
 *
 * Build: gcc -std=3Dc99 -o test test.c -lpci
 * Requirements: libpci-dev, root privileges, ATI Rage 128 Pro hardware
 * Note: Run with X.org idle (SSH session recommended)
 */
#include <stdio.h>
#include <sys/mman.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <pci/pci.h>

#define ATI_VENDOR_ID            0x1002
#define MAX_ATI_DEVICES          10

#define DP_GUI_MASTER_CNTL       0x146c

#define SRC_SC_BOTTOM_RIGHT      0x16f4
#define SRC_SC_BOTTOM            0x165C
#define SRC_SC_RIGHT             0x1654
#define DEFAULT_SC_BOTTOM_RIGHT  0x16e8

#define SC_TOP_LEFT              0x1640
#define SC_LEFT                  0x1640
#define SC_TOP                   0x1648

#define SC_BOTTOM_RIGHT          0x1644
#define SC_RIGHT                 0x1644
#define SC_BOTTOM                0x164C

#define DST_OFFSET               0x1404
#define DST_PITCH                0x1408
#define DP_BRUSH_FRGD_CLR        0x147c
#define DP_WRITE_MASK            0x16cc
#define DST_HEIGHT               0x1410
#define DST_X_Y                  0x1594
#define DST_WIDTH_X              0x1588

#define FATAL do { fprintf(stderr, "Error at line %d, file %s (%d) [%s]\n",=
 \
  __LINE__, __FILE__, errno, strerror(errno)); exit(1); } while(0)

void run_tests(void *bar2);
struct pci_dev *find_device(struct pci_access *pacc,
                            char *name_out, int name_len);
void print_devices(struct pci_access *pacc);
void *map_bar(struct pci_dev *dev, int bar_idx);
static inline uint32_t reg_read(void *base, uint32_t offset);
static inline uint32_t reg_write(void *base, uint32_t offset, uint32_t valu=
e);

int main(int argc, char **argv) {
  struct pci_access *pacc =3D pci_alloc();
  char name[256];
  struct pci_dev *dev =3D find_device(pacc, name, sizeof(name));
  void *bar2 =3D map_bar(dev, 2);

  run_tests(bar2);

  return 0;
}

void test_dst_clipping(void *bar2) {
  uint32_t dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  uint32_t default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIG=
HT);
  uint32_t sc_bottom =3D reg_read(bar2, SC_BOTTOM);
  uint32_t sc_right =3D reg_read(bar2, SC_RIGHT);
  uint32_t sc_top =3D reg_read(bar2, SC_TOP);
  uint32_t sc_left =3D reg_read(bar2, SC_LEFT);

  printf("Test DST clipping\n");
  printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n\n");

  printf("** Initializing DEFAULT_SC_BOTTOM_RIGHT to 0x0 **\n");
  printf("** Initializing SC_BOTTOM to 0x0 **\n");
  printf("** Initializing SC_RIGHT to 0x0 **\n");
  printf("** Initializing SC_TOP to 0x0 **\n");
  printf("** Initializing SC_LEFT to 0x0 **\n");

  reg_write(bar2, DEFAULT_SC_BOTTOM_RIGHT, 0x0);
  reg_write(bar2, SC_BOTTOM, 0x0);
  reg_write(bar2, SC_RIGHT, 0x0);
  reg_write(bar2, SC_TOP, 0x0);
  reg_write(bar2, SC_LEFT, 0x0);

  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIGHT);
  sc_bottom =3D reg_read(bar2, SC_BOTTOM);
  sc_right =3D reg_read(bar2, SC_RIGHT);
  sc_top =3D reg_read(bar2, SC_TOP);
  sc_left =3D reg_read(bar2, SC_LEFT);

  printf("\n");
  printf("Initial State\n");
  printf("------------------------------------\n");
  printf("DEFAULT_GUI_MASTER_CNTL: 0x%08x\n", dp_gui_master_cntl);
  printf("DEFAULT_SC_BOTTOM_RIGHT: 0x%08x\n", default_sc_bottom_right);
  printf("SC_BOTTOM:               0x%08x\n", sc_bottom);
  printf("SC_RIGHT:                0x%08x\n", sc_right);
  printf("SC_TOP:                  0x%08x\n", sc_top);
  printf("SC_LEFT:                 0x%08x\n", sc_left);
  printf("\n");

  printf("** Setting DEFAULT_SC_BOTTOM_RIGHT to 0x0aaa0bbb **\n");
  printf("** Setting SC_BOTTOM to 0x111 **\n");
  printf("** Setting SC_RIGHT to 0x222 **\n");
  printf("** SETTING SC_TOP to 0x333 **\n");
  printf("** SETTING SC_LEFT to 0x444 **\n");
  reg_write(bar2, DEFAULT_SC_BOTTOM_RIGHT, 0x0aaa0bbb);
  reg_write(bar2, SC_BOTTOM, 0x00000111);
  reg_write(bar2, SC_RIGHT, 0x00000222);
  reg_write(bar2, SC_TOP, 0x00000333);
  reg_write(bar2, SC_LEFT, 0x00000444);

  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIGHT);
  sc_bottom =3D reg_read(bar2, SC_BOTTOM);
  sc_right =3D reg_read(bar2, SC_RIGHT);
  sc_top =3D reg_read(bar2, SC_TOP);
  sc_left =3D reg_read(bar2, SC_LEFT);

  printf("\n");
  printf("State After Setting\n");
  printf("------------------------------------\n");
  printf("DEFAULT_GUI_MASTER_CNTL: 0x%08x\n", dp_gui_master_cntl);
  printf("DEFAULT_SC_BOTTOM_RIGHT: 0x%08x\n", default_sc_bottom_right);
  printf("SC_BOTTOM:               0x%08x\n", sc_bottom);
  printf("SC_RIGHT:                0x%08x\n", sc_right);
  printf("SC_TOP:                  0x%08x\n", sc_top);
  printf("SC_LEFT:                 0x%08x\n", sc_left);
  printf("\n");

  printf("** Setting GMC_DST_CLIPPING to default **\n");
  reg_write(bar2, DP_GUI_MASTER_CNTL, dp_gui_master_cntl & ~0x8);
  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);

  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIGHT);
  sc_bottom =3D reg_read(bar2, SC_BOTTOM);
  sc_right =3D reg_read(bar2, SC_RIGHT);
  sc_top =3D reg_read(bar2, SC_TOP);
  sc_left =3D reg_read(bar2, SC_LEFT);

  printf("\n");
  printf("State After Setting Default\n");
  printf("------------------------------------\n");
  printf("DEFAULT_GUI_MASTER_CNTL: 0x%08x\n", dp_gui_master_cntl);
  printf("DEFAULT_SC_BOTTOM_RIGHT: 0x%08x\n", default_sc_bottom_right);
  printf("SC_BOTTOM:               0x%08x\n", sc_bottom);
  printf("SC_RIGHT:                0x%08x\n", sc_right);
  printf("SC_TOP:                  0x%08x\n", sc_top);
  printf("SC_LEFT:                 0x%08x\n", sc_left);
  printf("\n");

  printf("** Setting GMC_DST_CLIPPING to leave alone **\n");
  reg_write(bar2, DP_GUI_MASTER_CNTL, dp_gui_master_cntl | 0x8);
  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);

  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIGHT);
  sc_bottom =3D reg_read(bar2, SC_BOTTOM);
  sc_right =3D reg_read(bar2, SC_RIGHT);
  sc_top =3D reg_read(bar2, SC_TOP);
  sc_left =3D reg_read(bar2, SC_LEFT);

  printf("\n");
  printf("State After Setting Leave Alone\n");
  printf("------------------------------------\n");
  printf("DEFAULT_GUI_MASTER_CNTL: 0x%08x\n", dp_gui_master_cntl);
  printf("DEFAULT_SC_BOTTOM_RIGHT: 0x%08x\n", default_sc_bottom_right);
  printf("SC_BOTTOM:               0x%08x\n", sc_bottom);
  printf("SC_RIGHT:                0x%08x\n", sc_right);
  printf("SC_TOP:                  0x%08x\n", sc_top);
  printf("SC_LEFT:                 0x%08x\n", sc_left);
  printf("\n");
}

void test_src_clipping(void *bar2) {
  uint32_t dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  uint32_t default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIG=
HT);
  uint32_t src_sc_bottom =3D reg_read(bar2, SRC_SC_BOTTOM);
  uint32_t src_sc_right =3D reg_read(bar2, SRC_SC_RIGHT);

  printf("Test SRC clipping\n");
  printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n\n");

  printf("** Initializing DEFAULT_SC_BOTTOM_RIGHT to 0x0 **\n");
  printf("** Initializing SRC_SC_BOTTOM to 0x0 **\n");
  printf("** Initializing SRC_SC_RIGHT to 0x0 **\n");

  reg_write(bar2, DEFAULT_SC_BOTTOM_RIGHT, 0x0);
  reg_write(bar2, SRC_SC_BOTTOM, 0x0);
  reg_write(bar2, SRC_SC_RIGHT, 0x0);

  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIGHT);
  src_sc_bottom =3D reg_read(bar2, SRC_SC_BOTTOM);
  src_sc_right =3D reg_read(bar2, SRC_SC_RIGHT);

  printf("\n");
  printf("Initial State\n");
  printf("------------------------------------\n");
  printf("DEFAULT_GUI_MASTER_CNTL: 0x%08x\n", dp_gui_master_cntl);
  printf("DEFAULT_SC_BOTTOM_RIGHT: 0x%08x\n", default_sc_bottom_right);
  printf("SRC_SC_BOTTOM:           0x%08x\n", src_sc_bottom);
  printf("SRC_SC_RIGHT:            0x%08x\n", src_sc_right);
  printf("\n");

  printf("** Setting DEFAULT_SC_BOTTOM_RIGHT to 0x0aaa0bbb **\n");
  printf("** Setting SRC_SC_BOTTOM to 0x111 **\n");
  printf("** Setting SRC_SC_RIGHT to 0x222 **\n");
  reg_write(bar2, DEFAULT_SC_BOTTOM_RIGHT, 0x0aaa0bbb);
  reg_write(bar2, SRC_SC_BOTTOM, 0x00000111);
  reg_write(bar2, SRC_SC_RIGHT, 0x00000222);

  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIGHT);
  src_sc_bottom =3D reg_read(bar2, SRC_SC_BOTTOM);
  src_sc_right =3D reg_read(bar2, SRC_SC_RIGHT);

  printf("\n");
  printf("State After Setting\n");
  printf("------------------------------------\n");
  printf("DEFAULT_GUI_MASTER_CNTL: 0x%08x\n", dp_gui_master_cntl);
  printf("DEFAULT_SC_BOTTOM_RIGHT: 0x%08x\n", default_sc_bottom_right);
  printf("SRC_SC_BOTTOM:           0x%08x\n", src_sc_bottom);
  printf("SRC_SC_RIGHT:            0x%08x\n", src_sc_right);
  printf("\n");

  printf("** Setting GMC_SRC_CLIPPING to default **\n");
  reg_write(bar2, DP_GUI_MASTER_CNTL, dp_gui_master_cntl & ~0x4);
  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);

  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIGHT);
  src_sc_bottom =3D reg_read(bar2, SRC_SC_BOTTOM);
  src_sc_right =3D reg_read(bar2, SRC_SC_RIGHT);

  printf("\n");
  printf("State After Setting Default\n");
  printf("------------------------------------\n");
  printf("DEFAULT_GUI_MASTER_CNTL: 0x%08x\n", dp_gui_master_cntl);
  printf("DEFAULT_SC_BOTTOM_RIGHT: 0x%08x\n", default_sc_bottom_right);
  printf("SRC_SC_BOTTOM:           0x%08x\n", src_sc_bottom);
  printf("SRC_SC_RIGHT:            0x%08x\n", src_sc_right);
  printf("\n");

  printf("** Setting GMC_SRC_CLIPPING to leave alone **\n");
  reg_write(bar2, DP_GUI_MASTER_CNTL, dp_gui_master_cntl | 0x4);
  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);

  dp_gui_master_cntl =3D reg_read(bar2, DP_GUI_MASTER_CNTL);
  default_sc_bottom_right =3D reg_read(bar2, DEFAULT_SC_BOTTOM_RIGHT);
  src_sc_bottom =3D reg_read(bar2, SRC_SC_BOTTOM);
  src_sc_right =3D reg_read(bar2, SRC_SC_RIGHT);

  printf("\n");
  printf("State After Setting Leave Alone\n");
  printf("------------------------------------\n");
  printf("DEFAULT_GUI_MASTER_CNTL: 0x%08x\n", dp_gui_master_cntl);
  printf("DEFAULT_SC_BOTTOM_RIGHT: 0x%08x\n", default_sc_bottom_right);
  printf("SRC_SC_BOTTOM:           0x%08x\n", src_sc_bottom);
  printf("SRC_SC_RIGHT:            0x%08x\n", src_sc_right);
  printf("\n");
}

void run_tests(void *bar2) {
  test_src_clipping(bar2);
  test_dst_clipping(bar2);
}

struct pci_dev *find_device(struct pci_access *pacc,
                            char *name_out, int name_len) {
  struct pci_dev *dev, *it;
  int device_count =3D 0;

  pci_init(pacc);
  pci_scan_bus(pacc);

  for (it =3D pacc->devices; it; it =3D it->next) {
    if (it->vendor_id =3D=3D ATI_VENDOR_ID) {
      if (device_count =3D=3D 0) {
        dev =3D it;
      }
      device_count +=3D 1;
    }
  }

  if (device_count =3D=3D 0) {
    printf("No ATI devices found\n");
    exit(1);
  }

  if (device_count > 1) {
    printf("Found multiple ATI devices:\n");
    print_devices(pacc);
  }

  pci_lookup_name(pacc, name_out, name_len,
                  PCI_LOOKUP_VENDOR | PCI_LOOKUP_DEVICE,
                  dev->vendor_id, dev->device_id);

  printf("# %s\n\n", name_out);

  return dev;
}

void print_devices(struct pci_access *pacc) {
  struct pci_dev *dev;
  char name[256];

  for (dev =3D pacc->devices; dev; dev =3D dev->next) {
    if (dev->vendor_id !=3D ATI_VENDOR_ID) continue;
    pci_lookup_name(pacc, name, sizeof(name),
                    PCI_LOOKUP_VENDOR | PCI_LOOKUP_DEVICE,
                    dev->vendor_id, dev->device_id);
    printf("\t- %s\n", name);
  }
}

void *map_bar(struct pci_dev *dev, int bar_idx) {
  char pci_loc[32];
  sprintf(pci_loc, "%04x:%02x:%02x.%d", dev->domain, dev->bus,
          dev->dev, dev->func);

  char base_path[256];
  sprintf(base_path, "/sys/bus/pci/devices/%s", pci_loc);

  char bar_path[256];
  sprintf(bar_path, "%s/resource%d", base_path, bar_idx);

  int bar_fd =3D open(bar_path, O_RDWR | O_SYNC);
  if (bar_fd =3D=3D -1) FATAL;

  void *bar =3D mmap(NULL, dev->size[bar_idx], PROT_READ | PROT_WRITE,
                   MAP_SHARED, bar_fd, 0);
  if (bar =3D=3D (void *) -1) FATAL;

  return bar;
}

static inline uint32_t reg_read(void *base, uint32_t offset) {
  volatile uint32_t *reg =3D (volatile uint32_t *)(base + offset);
  return *reg;
}

static inline uint32_t reg_write(void *base, uint32_t offset, uint32_t valu=
e) {
  volatile uint32_t *reg =3D (volatile uint32_t *)(base + offset);
  *reg =3D value;
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

I haven't tested them yet, but I'll also run this test for
GMC_SRC_PITCH_OFFSET_CNTL and GMC_DST_PITCH_OFFSET_CNTL to confirm that
they have the same behavior.

