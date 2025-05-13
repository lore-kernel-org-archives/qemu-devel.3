Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE04EC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqxn-00007K-JD; Tue, 13 May 2025 10:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEqxj-0008WM-0I
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEqxg-0001VP-3V
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747147824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAJtFHzLrwgdoYW8zFPNKaN+ZC0d69c/CaY/ZJAKmFc=;
 b=VTniTzk0lqDSaDBzSORO3Q+TiR8Bw3rjj/UORAiUFU11yuskor0UwMCH5AutbQLia39tCj
 eAKHaSeFKVG6g3ftdsSXGLe/4qo9qsgTb5F6gRKY2x86l+4cZlTilVMBYd9Rh0VSo1GvvY
 8bKXObRbGbvWFVVxs6U+fCKwf7zQ7ak=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-bTCzMe-DPSSvrlVY9tcRHA-1; Tue, 13 May 2025 10:50:23 -0400
X-MC-Unique: bTCzMe-DPSSvrlVY9tcRHA-1
X-Mimecast-MFC-AGG-ID: bTCzMe-DPSSvrlVY9tcRHA_1747147822
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43e9a3d2977so40605255e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747147822; x=1747752622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAJtFHzLrwgdoYW8zFPNKaN+ZC0d69c/CaY/ZJAKmFc=;
 b=NWFVS4/ByKTcHltoE/MSKoEVimqarw4uiXHjWwg31L8XeszHLQNbXzXqQmlApUy/DZ
 f7VOxXQdc8nJ4tT6XBpUvCEpPGode7ib7LVtIZxKY1YZSC89dT4TgHvE3V83cXWoRr16
 3LJ1eFf6740jQqAlXGEYpJra/nUBRMBcl946Sfg3UNY8cVItdWywVxxgg0y6sHwPtos7
 JxqRqdPTDC4mu8ovOAhuV7gxZeeJ61G0yl2DWPFSHfCRT7AsIO/qp/nD+OpMGgezrQG5
 ahO/ntlNuGaptnuk951gNPTUnSm+YgKEzz1fHc3b+5l3VSwPymm6Z9ukZQjfQ4OifHsH
 gxUQ==
X-Gm-Message-State: AOJu0YzljeYo8hT6cfl51OWSWivkj4VGfaiomA3TTbjzKMl7yKSXUqRA
 FfKucUbp1SlMbdbQJ8IFtUJh1bfhMt7DVzYI9pPQ/DMqQkk+gHCXjJ9fetmvdLolNjlEwcZ2Lx1
 DLJ/jr4p9DqoH5C6tV+2ok68iZydbQizFkwSeEWG0BYWss4LHLGUN
X-Gm-Gg: ASbGnct+YEwTyhYiG8Bmol1tLnPUv4ySaK6yom04T6TB8AiEhYnPGLmGjfxyNC77zbi
 EOS8uNFo9VjJFPym4B8P7tyosSwguvwY095ZMYY/a22uN8OTP/df+GdREmROUb2r2WG36hvXNmD
 DmJcKt+zsamhLfOv4ON8sWrcMqRJS8RL8zmweK20lT2mZw+bdCdUu1S4Onbf5x5h2DdU+B7eTOt
 7f6/y3t0pOnD89fwarydmTJ1QliJrGZUpfyjow8RH9oZecdeiVG+IdebP+AiqCpXchSrD8wivOm
 FSkz6Q==
X-Received: by 2002:a05:600c:34d5:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-442d6d3e243mr176236275e9.10.1747147822144; 
 Tue, 13 May 2025 07:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk9OONl32sEvVscZx+q7p1Fdyh2fRoxb6HuZHihSRy/AQ8qU0OZwHb28WeUEqtkYnE1R0TPg==
X-Received: by 2002:a05:600c:34d5:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-442d6d3e243mr176236055e9.10.1747147821719; 
 Tue, 13 May 2025 07:50:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d687adc0sm168434475e9.35.2025.05.13.07.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 07:50:20 -0700 (PDT)
Date: Tue, 13 May 2025 10:50:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>
Subject: Re: [PATCH v4 14/19] atc: Add unit tests
Message-ID: <20250513105003-mutt-send-email-mst@kernel.org>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
 <20250227105339.388598-15-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227105339.388598-15-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 27, 2025 at 10:54:47AM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>  tests/unit/meson.build |   1 +
>  tests/unit/test-atc.c  | 527 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 528 insertions(+)
>  create mode 100644 tests/unit/test-atc.c
> 
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index d5248ae51d..810197d5e1 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -48,6 +48,7 @@ tests = {
>    'test-qapi-util': [],
>    'test-interval-tree': [],
>    'test-fifo': [],
> +  'test-atc': [],
>  }
>  


needs to depend on testblock then?


>  if have_system or have_tools
> diff --git a/tests/unit/test-atc.c b/tests/unit/test-atc.c
> new file mode 100644
> index 0000000000..0d1c1b7ca7
> --- /dev/null
> +++ b/tests/unit/test-atc.c
> @@ -0,0 +1,527 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "util/atc.h"
> +
> +static inline bool tlb_entry_equal(IOMMUTLBEntry *e1, IOMMUTLBEntry *e2)
> +{
> +    if (!e1 || !e2) {
> +        return !e1 && !e2;
> +    }
> +    return e1->iova == e2->iova &&
> +            e1->addr_mask == e2->addr_mask &&
> +            e1->pasid == e2->pasid &&
> +            e1->perm == e2->perm &&
> +            e1->target_as == e2->target_as &&
> +            e1->translated_addr == e2->translated_addr;
> +}
> +
> +static void assert_lookup_equals(ATC *atc, IOMMUTLBEntry *target,
> +                                 uint32_t pasid, hwaddr iova)
> +{
> +    IOMMUTLBEntry *result;
> +    result = atc_lookup(atc, pasid, iova);
> +    g_assert(tlb_entry_equal(result, target));
> +}
> +
> +static void check_creation(uint64_t page_size, uint8_t address_width,
> +                           uint8_t levels, uint8_t level_offset,
> +                           bool should_work) {
> +    ATC *atc = atc_new(page_size, address_width);
> +    if (atc) {
> +        g_assert(atc->levels == levels);
> +        g_assert(atc->level_offset == level_offset);
> +
> +        atc_destroy(atc);
> +        g_assert(should_work);
> +    } else {
> +        g_assert(!should_work);
> +    }
> +}
> +
> +static void test_creation_parameters(void)
> +{
> +    check_creation(8, 39, 3, 9, false);
> +    check_creation(4095, 39, 3, 9, false);
> +    check_creation(4097, 39, 3, 9, false);
> +    check_creation(8192, 48, 0, 0, false);
> +
> +    check_creation(4096, 38, 0, 0, false);
> +    check_creation(4096, 39, 3, 9, true);
> +    check_creation(4096, 40, 0, 0, false);
> +    check_creation(4096, 47, 0, 0, false);
> +    check_creation(4096, 48, 4, 9, true);
> +    check_creation(4096, 49, 0, 0, false);
> +    check_creation(4096, 56, 0, 0, false);
> +    check_creation(4096, 57, 5, 9, true);
> +    check_creation(4096, 58, 0, 0, false);
> +
> +    check_creation(16384, 35, 0, 0, false);
> +    check_creation(16384, 36, 2, 11, true);
> +    check_creation(16384, 37, 0, 0, false);
> +    check_creation(16384, 46, 0, 0, false);
> +    check_creation(16384, 47, 3, 11, true);
> +    check_creation(16384, 48, 0, 0, false);
> +    check_creation(16384, 57, 0, 0, false);
> +    check_creation(16384, 58, 4, 11, true);
> +    check_creation(16384, 59, 0, 0, false);
> +}
> +
> +static void test_single_entry(void)
> +{
> +    IOMMUTLBEntry entry = {
> +        .iova = 0x123456789000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 5,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +
> +    ATC *atc = atc_new(4096, 48);
> +    g_assert(atc);
> +
> +    assert_lookup_equals(atc, NULL, entry.pasid,
> +                         entry.iova + (entry.addr_mask / 2));
> +
> +    atc_create_address_space_cache(atc, entry.pasid);
> +    g_assert(atc_update(atc, &entry) == 0);
> +
> +    assert_lookup_equals(atc, NULL, entry.pasid + 1,
> +                         entry.iova + (entry.addr_mask / 2));
> +    assert_lookup_equals(atc, &entry, entry.pasid,
> +                         entry.iova + (entry.addr_mask / 2));
> +
> +    atc_destroy(atc);
> +}
> +
> +static void test_single_entry_2(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xabcdef200000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eedULL,
> +    };
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_update(atc, &e1);
> +
> +    assert_lookup_equals(atc, NULL, e1.pasid, 0xabcdef201000ULL);
> +
> +    atc_destroy(atc);
> +}
> +
> +static void test_page_boundaries(void)
> +{
> +    static const uint32_t pasid = 5;
> +    static const hwaddr page_size = 4096;
> +
> +    /* 2 consecutive entries */
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0x123456789000ULL,
> +        .addr_mask = page_size - 1,
> +        .pasid = pasid,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = e1.iova + page_size,
> +        .addr_mask = page_size - 1,
> +        .pasid = pasid,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x900df00dULL,
> +    };
> +
> +    ATC *atc = atc_new(page_size, 48);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    /* creating the address space twice should not be a problem */
> +    atc_create_address_space_cache(atc, e1.pasid);
> +
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova - 1);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova + e1.addr_mask);
> +    g_assert((e1.iova + e1.addr_mask + 1) == e2.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova + e2.addr_mask);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova + e2.addr_mask + 1);
> +
> +    assert_lookup_equals(atc, NULL, e1.pasid + 10, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid + 10, e2.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_huge_page(void)
> +{
> +    static const uint32_t pasid = 5;
> +    static const hwaddr page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0x123456600000ULL,
> +        .addr_mask = 0x1fffffULL,
> +        .pasid = pasid,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +    hwaddr addr;
> +
> +    ATC *atc = atc_new(page_size, 48);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_update(atc, &e1);
> +
> +    for (addr = e1.iova; addr <= e1.iova + e1.addr_mask; addr += page_size) {
> +        assert_lookup_equals(atc, &e1, e1.pasid, addr);
> +    }
> +    /* addr is now out of the huge page */
> +    assert_lookup_equals(atc, NULL, e1.pasid, addr);
> +    atc_destroy(atc);
> +}
> +
> +static void test_pasid(void)
> +{
> +    hwaddr addr = 0xaaaaaaaaa000ULL;
> +    IOMMUTLBEntry e1 = {
> +        .iova = addr,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 8,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = addr,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 2,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xb001ULL,
> +    };
> +    uint16_t i;
> +
> +    ATC *atc = atc_new(4096, 48);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_create_address_space_cache(atc, e2.pasid);
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +
> +    for (i = 0; i <= MAX(e1.pasid, e2.pasid) + 1; ++i) {
> +        if (i == e1.pasid || i == e2.pasid) {
> +            continue;
> +        }
> +        assert_lookup_equals(atc, NULL, i, addr);
> +    }
> +    assert_lookup_equals(atc, &e1, e1.pasid, addr);
> +    assert_lookup_equals(atc, &e1, e1.pasid, addr);
> +    atc_destroy(atc);
> +}
> +
> +static void test_large_address(void)
> +{
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaaaaaaaaa000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 8,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = 0x1f00baaaaabf000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = e1.pasid,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xdeadbeefULL,
> +    };
> +
> +    ATC *atc = atc_new(4096, 57);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_bigger_page(void)
> +{
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaabbccdde000ULL,
> +        .addr_mask = 0x1fffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +    hwaddr i;
> +
> +    ATC *atc = atc_new(8192, 43);
> +
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_update(atc, &e1);
> +
> +    i = e1.iova & (~e1.addr_mask);
> +    assert_lookup_equals(atc, NULL, e1.pasid, i - 1);
> +    while (i <= e1.iova + e1.addr_mask) {
> +        assert_lookup_equals(atc, &e1, e1.pasid, i);
> +        ++i;
> +    }
> +    assert_lookup_equals(atc, NULL, e1.pasid, i);
> +    atc_destroy(atc);
> +}
> +
> +static void test_unknown_pasid(void)
> +{
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaabbccfff000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +
> +    ATC *atc = atc_new(4096, 48);
> +    g_assert(atc_update(atc, &e1) != 0);
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_invalidation(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaabbccddf000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = 0xffe00000ULL,
> +        .addr_mask = 0x1fffffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xb000001ULL,
> +    };
> +    IOMMUTLBEntry e3;
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +
> +    atc_update(atc, &e1);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    atc_invalidate(atc, &e1);
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    atc_invalidate(atc, &e2);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +
> +    /* invalidate a huge page by invalidating a small region */
> +    for (hwaddr addr = e2.iova; addr <= (e2.iova + e2.addr_mask);
> +         addr += page_size) {
> +        atc_update(atc, &e2);
> +        assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +        e3 = (IOMMUTLBEntry){
> +            .iova = addr,
> +            .addr_mask = page_size - 1,
> +            .pasid = e2.pasid,
> +            .perm = IOMMU_RW,
> +            .translated_addr = 0,
> +        };
> +        atc_invalidate(atc, &e3);
> +        assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +    }
> +    atc_destroy(atc);
> +}
> +
> +static void test_delete_address_space_cache(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0xaabbccddf000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = e1.iova,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 2,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eeeeeedULL,
> +    };
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +
> +    atc_update(atc, &e1);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    atc_invalidate(atc, &e2); /* unkown pasid : is a nop*/
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +
> +    atc_create_address_space_cache(atc, e2.pasid);
> +    atc_update(atc, &e2);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    atc_invalidate(atc, &e1);
> +    /* e1 has been removed but e2 is still there */
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +
> +    atc_update(atc, &e1);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +
> +    atc_delete_address_space_cache(atc, e2.pasid);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_invalidate_entire_address_space(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0x1000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = 0xfffffffff000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xbeefULL,
> +    };
> +    IOMMUTLBEntry e3 = {
> +        .iova = 0,
> +        .addr_mask = 0xffffffffffffffffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0,
> +    };
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +    atc_invalidate(atc, &e3);
> +    /* e1 has been removed but e2 is still there */
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +
> +    atc_destroy(atc);
> +}
> +
> +static void test_reset(void)
> +{
> +    static uint64_t page_size = 4096;
> +    IOMMUTLBEntry e1 = {
> +        .iova = 0x1000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 1,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0x5eedULL,
> +    };
> +    IOMMUTLBEntry e2 = {
> +        .iova = 0xfffffffff000ULL,
> +        .addr_mask = 0xfffULL,
> +        .pasid = 2,
> +        .perm = IOMMU_RW,
> +        .translated_addr = 0xbeefULL,
> +    };
> +
> +    ATC *atc = atc_new(page_size , 48);
> +    atc_create_address_space_cache(atc, e1.pasid);
> +    atc_create_address_space_cache(atc, e2.pasid);
> +    atc_update(atc, &e1);
> +    atc_update(atc, &e2);
> +
> +    assert_lookup_equals(atc, &e1, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, &e2, e2.pasid, e2.iova);
> +
> +    atc_reset(atc);
> +
> +    assert_lookup_equals(atc, NULL, e1.pasid, e1.iova);
> +    assert_lookup_equals(atc, NULL, e2.pasid, e2.iova);
> +    atc_destroy(atc);
> +}
> +
> +static void test_get_max_number_of_pages(void)
> +{
> +    static uint64_t page_size = 4096;
> +    hwaddr base = 0xc0fee000; /* aligned */
> +    ATC *atc = atc_new(page_size , 48);
> +    g_assert(atc_get_max_number_of_pages(atc, base, page_size / 2) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base, page_size) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base, page_size + 1) == 2);
> +
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10, 1) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size - 10) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10,
> +                                         page_size - 10 + 1) == 2);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10,
> +                                         page_size - 10 + 2) == 2);
> +
> +    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 1) == 1);
> +    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 2) == 2);
> +    g_assert(atc_get_max_number_of_pages(atc, base + page_size - 1, 3) == 2);
> +
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10, page_size * 20) == 21);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10,
> +                                         (page_size * 20) + (page_size - 10))
> +                                          == 21);
> +    g_assert(atc_get_max_number_of_pages(atc, base + 10,
> +                                         (page_size * 20) +
> +                                         (page_size - 10 + 1)) == 22);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/atc/test_creation_parameters", test_creation_parameters);
> +    g_test_add_func("/atc/test_single_entry", test_single_entry);
> +    g_test_add_func("/atc/test_single_entry_2", test_single_entry_2);
> +    g_test_add_func("/atc/test_page_boundaries", test_page_boundaries);
> +    g_test_add_func("/atc/test_huge_page", test_huge_page);
> +    g_test_add_func("/atc/test_pasid", test_pasid);
> +    g_test_add_func("/atc/test_large_address", test_large_address);
> +    g_test_add_func("/atc/test_bigger_page", test_bigger_page);
> +    g_test_add_func("/atc/test_unknown_pasid", test_unknown_pasid);
> +    g_test_add_func("/atc/test_invalidation", test_invalidation);
> +    g_test_add_func("/atc/test_delete_address_space_cache",
> +                    test_delete_address_space_cache);
> +    g_test_add_func("/atc/test_invalidate_entire_address_space",
> +                    test_invalidate_entire_address_space);
> +    g_test_add_func("/atc/test_reset", test_reset);
> +    g_test_add_func("/atc/test_get_max_number_of_pages",
> +                    test_get_max_number_of_pages);
> +    return g_test_run();
> +}
> -- 
> 2.48.1


