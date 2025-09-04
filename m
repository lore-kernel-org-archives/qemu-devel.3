Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CA6CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 14:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuAXW-0005fK-KJ; Thu, 04 Sep 2025 10:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuAXT-0005eT-QR
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuAXJ-0001sR-VU
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756994512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2FF7QYh1G4sd68hTZrP6WTKiZuCRd21KT76pY9ILtQ=;
 b=eHcHHZQVldfylr0nC0J3Kr2WIq0fYWEMNeELDDDpoRwp2hIOfLALFpwc4wxz9Jg4LAd6YL
 c3E0Wkzx26VwFmBkW0Zd9mguJ4rtvHJ8Hk5aTmyapFc2YEhs1AMbWiBC122cG4LbgNURu3
 pf7DLYXfR8nlj6R4ESVqznO//fclBSI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-9jwLEU8XMoGzpySsPbmpJg-1; Thu, 04 Sep 2025 10:01:51 -0400
X-MC-Unique: 9jwLEU8XMoGzpySsPbmpJg-1
X-Mimecast-MFC-AGG-ID: 9jwLEU8XMoGzpySsPbmpJg_1756994510
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-80fcac99fe1so30578385a.2
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 07:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756994510; x=1757599310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2FF7QYh1G4sd68hTZrP6WTKiZuCRd21KT76pY9ILtQ=;
 b=xRGaYwYQ0XMZxenzhok1HuHCRmGRBHl3k44VDnLkTxAknD/VvgR9NXz0JhBQrf0PLS
 c61VASI0z7RIp6fa0/sACoJ1aXV6EFWv0lgrG3d2HzKRMXVnqw5YlOf+PsAWWDr4oUhz
 z3jpPYSusmkO02f1N/dPHdMM7CMyCfS8rckKhvrvxAFyK/3LAmcjHEM4SopIxYVtAvG4
 IL99ZtuWgKHGAIIsP+v+PUOLOadhk/jJ17UGdHqpgNfq1/cX1B4aB+ZgOodOVj8UMW4u
 CrA/syHry25IO32LvilFCFU4q0dFV85drZTdXcLCkVBv5otagGNaV972Wc5Tw3tBFuxn
 0O9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBALuMTZjMM8wCikiaofGLa/DBiYEZXLwPsvLQ7lOy1wOJvmAWD7RzZyJlLi1En0Q9jG5BJlcbkvMN@nongnu.org
X-Gm-Message-State: AOJu0YzIbpExJ0U21AJIlTcM4G9AiU3PKaFbg+M1xkaQHqoPqR3QduSG
 AaaP13h/hXakNRKFwtf7q3l+nK9LRQIYoey8MPzjZtjH9T2u95t3IxL5ys4z5F5fKGmT02AtGVH
 HRSikU+9g6ZJGCOvt0kU/yQsXwOwjvzIhVilL3dUk505FYKrSvuLnjq4N
X-Gm-Gg: ASbGncv6Tt0qx49/wX2WZXItCaU+5VnTE33glmn65u+bWc8lfgze7YBbMvD7kH/0um5
 /jTi+w9+aLOu8DPDISXyf3fODv26crlZTxARorRzODrwgFPXGRu58Ex86RKNmBM14x45xnQFN8C
 LSB3RZcT+xqa0O8mE+HGDpyBhs31ALn2zKbJYgYdDBmK4kiLo+0/b6rYZpih/zCbRM9R7/O4qFr
 YecRaxWYdh5b2Wel5SEpCDDrW8IZOHl7ZGdKFfHQf2c5X1D6I3iJiIe2hurpmAphftxccIXS8yg
 aiQt5KgnXaKavHxTOe1mqgoaB+LyeU24
X-Received: by 2002:a05:620a:2954:b0:809:8ccc:ba7c with SMTP id
 af79cd13be357-8098cccbb97mr872332885a.29.1756994509990; 
 Thu, 04 Sep 2025 07:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMNV+IYKzorYL3x13harapQjY27o7mbqLf8/D+PtqSi5EgT37hw9CVgjbMnql3fCapJDAllw==
X-Received: by 2002:a05:620a:2954:b0:809:8ccc:ba7c with SMTP id
 af79cd13be357-8098cccbb97mr872324985a.29.1756994509259; 
 Thu, 04 Sep 2025 07:01:49 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-80aa6e4914csm282846485a.16.2025.09.04.07.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 07:01:48 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:01:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: CJ Chen <cjchen@igel.co.jp>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Subject: Re: [RFC PATCH v2 8/9] hw/misc: add test device for memory access
Message-ID: <aLmbv0ZEKjPFuYxt@x1.local>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-9-cjchen@igel.co.jp>
 <CAFEAcA9FAnnQrAf1eUPr1=FQ+=Wbu13gyfj3T3z+k6BhxHj6uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9FAnnQrAf1eUPr1=FQ+=Wbu13gyfj3T3z+k6BhxHj6uQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 01, 2025 at 06:03:41PM +0100, Peter Maydell wrote:
> Could we have a comment in this header file that documents
> what interface the test device presents to tests, please?
> Both this patch and the test-case patch are hard to
> review, because I don't know what the test device is
> trying to do or what the test code is able to assume
> about the test device.

Since the series is withdrawed.. but still I feel like I'll need to read
this series when it's picked up again, I took some time (while the brain
cache is still around..) study the code, I think I get the rough idea of
what this testdev is about.  If it's gonna be picked up by anyone, hope
below could help a bit.  Also for future myself..

Firstly, the testdev creates a bunch of MRs, with all kinds of the
attributes to cover all max/min access sizes possible & unaligned access &
endianess.  The test cases are exactly tailored for this testdev, as the
testcase needs to know exactly which offset contains which type of MR.  The
tests must be run correspondingly on the paired MR to work.

There're 16 groups of MRs / tests, each group contains below num of MRs:

#define N_OPS_LIST_LITTLE_B_VALID   80
#define N_OPS_LIST_LITTLE_B_INVALID 40
#define N_OPS_LIST_LITTLE_W_VALID   60
#define N_OPS_LIST_LITTLE_W_INVALID 30
#define N_OPS_LIST_LITTLE_L_VALID   40
#define N_OPS_LIST_LITTLE_L_INVALID 20
#define N_OPS_LIST_LITTLE_Q_VALID   20
#define N_OPS_LIST_LITTLE_Q_INVALID 10
#define N_OPS_LIST_BIG_B_VALID      80
#define N_OPS_LIST_BIG_B_INVALID    40
#define N_OPS_LIST_BIG_W_VALID      60
#define N_OPS_LIST_BIG_W_INVALID    30
#define N_OPS_LIST_BIG_L_VALID      40
#define N_OPS_LIST_BIG_L_INVALID    20
#define N_OPS_LIST_BIG_Q_VALID      20
#define N_OPS_LIST_BIG_Q_INVALID    10

That's a total of 600 (which is, N_OPS_LIST) MRs at the base address of the
testdev, specified by, for example:

  -device memaccess-testdev,address=0x10000000

Each MR will be 32B (MEMACCESS_TESTDEV_REGION_SIZE) in size, sequentially
appended and installed to base address offset. All of them internally
backed by:

    testdev->mr_data = g_malloc(MEMACCESS_TESTDEV_MR_DATA_SIZE);

Here, BIG/LITTLE decides the endianess of the MR, B/W/L/Q decides the
min_access_size of the MR, which isn't clear at all to me..  IIUC it's
hidden inside the skip_core() check where it skips anything except when
valid_min == required_min.  So only those MRs that satisfy will be created.

And just to mention, IIUC these numbers are not random either, they are
exactly how many possible MRs that we can create under the specific
category of MR group.  Changing that could either causing uninitialized MRs
(under some group) or trigger assertions saying MR list too small:

fill_ops_list:
        if (idx > ops_len) {
                g_assert_not_reached();
        }

This is not clear either.. better document this if it will be picked up one
day.

An example for definition of N_OPS_LIST_LITTLE_B_VALID: we can create 80
such MRs when the MR is (1) LITTLE (2) min_access_size=1 (3) allows
.valid.unaligned.  We'll skip the rest in skip_core() when building the
list of MRs.  And yes, here (3) isn't clear either: VALID here means "the
MR allows unaligned access from API level", which implies
.valid.unaligned=true.  OTOH, INVALID implies .valid.unaligned=false.
NOTE: it doesn't imply at all about .impl.unaligned.

The test case should be tailored for this device, because for each test it
will run, it'll run exactly on top of the group of MRs that the test case
pairs with.

Taking example of big_w_valid(): it'll run the test on all MRs that is (1)
BIG, (2) min_access_size=2, (3) VALID to use unaligned access, aka,
.valid.unaligned=true.

Said above, I'll also raise a question that I don't understand, on the
testdev implementation.  It's about endianess of the MR and how data
endianess is processed in the test dev.  Please shoot if anyone knows.

Again, taking the example of BIG write() of a test MR, I wonder why the
testdev has this:

static void memaccess_testdev_write_big(void *opaque, hwaddr addr,
                                        uint64_t data, unsigned int size)
{
    g_assert(addr + size < MEMACCESS_TESTDEV_REGION_SIZE);
    void *d = (uint8_t *)opaque + addr;
    stn_be_p(d, size, data);
}

It means when the ->write() triggers, it assumes "data" here is host
endianess, then convert that to MR's endianess, which is BE in this case.

But haven't we already done that before reaching ->write()?  Memory core
will do the endianess conversion (from HOST -> MR endianess) already here
before reaching the write() hook, AFAICT:

memory_region_dispatch_write()
    adjust_endianness(mr, &data, op);
        if ((op & MO_BSWAP) != devend_memop(mr->ops->endianness)) {

Here, MO_BSWAP shouldn't normally be set. devend_memop() should read BE.
On my host (x86_64) it means it'll swap once to MR endianess.  IIUC, now
the whole "data" field already in MR endianess and should be directly put
into the backend memdev storage.  I don't think I understand why above
stn_be_p() is not a memcpy().  Answers welcomed..

-- 
Peter Xu


