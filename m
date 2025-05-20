Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256F5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQqh-00071u-22; Tue, 20 May 2025 13:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uHQqe-00071P-Pz
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:33:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uHQqc-0007Na-Hp
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:33:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-742c9563fafso2601590b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747762428; x=1748367228; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dvHt4MKWTx6H9SefAKaE6RmCWcY4eukSsVO+Nryfw4E=;
 b=P3G7ADLVZlkE5XUs+uit/jhBSjCbTlzW/0FA9l9GabHpODzkt7oNBB9cT3VjcrgKI3
 46QWE8y8L4KVmlGsO8nBSSt2F2m29vMq5LusydFGWdeoJgAh/MHIEEXZUA7tIkVee2ZH
 M0kjt/9o3z6WypUnWqFjLWTJPw7fhYmuvkZYwUbIbLArOBvNke52M2A9Nd6pmCQepE/I
 /FhQnBbJkH3Kl+lLcASg8G5D4QqyeT6ox2AA5A5Kjfa7S2yOEXHB0/05KbMHY61kpm20
 9H8jTxRhOJY3lsvfCtq62/ddZe8ek53rq047UwPypJNTSrZ1J7m5uyPbk0tDfIUOKJTx
 1j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747762428; x=1748367228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvHt4MKWTx6H9SefAKaE6RmCWcY4eukSsVO+Nryfw4E=;
 b=QuhP2PoOw1V4kEgivUfRVTP3ndcsdcXl4ZW9VkMQ8a7t3LPQ35hak6CrvlyRxz24g9
 KrJodoYw0ib160Wk5iMhBSCHllOXizczx11XMpvEGjGfN8+oNv3uVuXlUZP9BjKgNTbG
 0hkdDEVHqbeZbJp+wQsEZuXIDkYf2C09PuR+VLbZfwfPzALkqqlMd1VU0MYrrlHAq2/F
 hYlaXCT5NG+Prz9BzT9bR13b6t6UuO9S5vfddHG13+dYc01Cx+6Znb87QesWbFEWgFSw
 N0+4StCx81qh8EosMWs1AHbBrwMfGS5HM9eLJgMBu+1KThHVvvhbP/b00yoZA6GO3cEf
 Qqww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc+ZQTx9tdO7RqLZSn+f5Ktkj5vvC9TuIIRkD+3b8GbAJgl5q2OWdoPpMKuoRT7q/aWz1dtcVF2WrI@nongnu.org
X-Gm-Message-State: AOJu0Ywa9xQ0EUGJSYPRr3sMEThY8JadOfii2lgKAsP4vTEJusp+JhEG
 gmb9WgAtGS/VLCp0OIBWeNFN0ChyURt55yTpDvtElACNpv5NlDGjbg2Y
X-Gm-Gg: ASbGncvpD6X8wl3bSnlDKTk8HFz1Lvrl/9SpUO9JFNeAuD5BeOn9TNo6ywrwXr6fzM4
 na+QwCYlwBxCj6h0Rp2hUf/K/+LnnhgQCKc3wd+BBF3jUG5FSfTLHx7uWlkaWrL941thpfYPVLA
 Va25UuUD67TNPhzfvCXDUQ092f0xcK0pwFK/l23AJ6FaWr9p0AL9Y2M8lNNKqcFh74lWhdvaToF
 tRWwyW7ZmV/VmwysxJ6drQKo29fjY8OjUSvwxp8Ax9kDs0GhISQx7P+65eaui3S4RUB2EfGlOUZ
 mRnZFBNM9iWk+JV/GT9Px1qv4SCbKTlMXeBMaH6UNi8rOjVHsug2Rlv2Bqye8oTXR2jqrAkyhAy
 O066EgTCU5AjO
X-Google-Smtp-Source: AGHT+IHAcdZkKlC59Ap9+9J6DwBg1+sCLP3pEe1x9i6V8VGJKQJDJKTZL5PwZiNGuTRniFOPIQyZnQ==
X-Received: by 2002:aa7:888e:0:b0:742:39fa:13df with SMTP id
 d2e1a72fcca58-742a98a2520mr24472509b3a.19.1747762428380; 
 Tue, 20 May 2025 10:33:48 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a982b847sm8464446b3a.102.2025.05.20.10.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:33:48 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 20 May 2025 17:33:46 +0000
To: Fan Ni <nifan.cxl@gmail.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 01/10] cxl-mailbox-utils: Move opcodes enum to new
 header file
Message-ID: <aCy8-vMEYsFaOiWC@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-2-anisa.su887@gmail.com>
 <aCyhv8Qz1LUpJKd3@lg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCyhv8Qz1LUpJKd3@lg>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, May 20, 2025 at 08:37:35AM -0700, Fan Ni wrote:
> On Thu, May 08, 2025 at 12:00:57AM +0000, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > In preparation for the next patch, move opcodes enum to new cxl_opcodes.h file
> > for visibility from mailbox-utils.c and i2c_mctp_cxl.c, which checks that
> > certain command sets are bound with the correct MCTP binding.
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c   | 68 ++----------------------------------
> >  include/hw/cxl/cxl_opcodes.h | 64 +++++++++++++++++++++++++++++++++
> 
> Should we put the opcodes into include/hw/cxl/cxl_mailbox.h instead of
> creating a new file. cxl_mailbox.h only has some macros.
> 
> Fan
> 
I had some discussion with Jonathan in the v1 thread about this. We
agreed it is fine to use mailbox.h because it only has a few macros in it,
but in case more things get added to it later, I made a separate file.
Then no need to re-organize later.
> 
> 
> >  2 files changed, 66 insertions(+), 66 deletions(-)
> >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index a02d130926..ed3294530f 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -23,6 +23,7 @@
> >  #include "qemu/uuid.h"
> >  #include "system/hostmem.h"
> >  #include "qemu/range.h"
> > +#include "hw/cxl/cxl_opcodes.h"
> >  
> >  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >  #define CXL_DC_EVENT_LOG_SIZE 8
> > @@ -36,7 +37,7 @@
> >  
> >  /*
> >   * How to add a new command, example. The command set FOO, with cmd BAR.
> > - *  1. Add the command set and cmd to the enum.
> > + *  1. Add the command set and cmd to the enum in cxl_opcodes.h.
> >   *     FOO    = 0x7f,
> >   *          #define BAR 0
> >   *  2. Implement the handler
> > @@ -59,71 +60,6 @@
> >   *  a register interface that already deals with it.
> >   */
> >  
> > -enum {
> > -    INFOSTAT    = 0x00,
> > -        #define IS_IDENTIFY   0x1
> > -        #define BACKGROUND_OPERATION_STATUS    0x2
> > -        #define GET_RESPONSE_MSG_LIMIT         0x3
> > -        #define SET_RESPONSE_MSG_LIMIT         0x4
> > -        #define BACKGROUND_OPERATION_ABORT     0x5
> > -    EVENTS      = 0x01,
> > -        #define GET_RECORDS   0x0
> > -        #define CLEAR_RECORDS   0x1
> > -        #define GET_INTERRUPT_POLICY   0x2
> > -        #define SET_INTERRUPT_POLICY   0x3
> > -    FIRMWARE_UPDATE = 0x02,
> > -        #define GET_INFO      0x0
> > -        #define TRANSFER      0x1
> > -        #define ACTIVATE      0x2
> > -    TIMESTAMP   = 0x03,
> > -        #define GET           0x0
> > -        #define SET           0x1
> > -    LOGS        = 0x04,
> > -        #define GET_SUPPORTED 0x0
> > -        #define GET_LOG       0x1
> > -        #define GET_LOG_CAPABILITIES   0x2
> > -        #define CLEAR_LOG     0x3
> > -        #define POPULATE_LOG  0x4
> > -    FEATURES    = 0x05,
> > -        #define GET_SUPPORTED 0x0
> > -        #define GET_FEATURE   0x1
> > -        #define SET_FEATURE   0x2
> > -    IDENTIFY    = 0x40,
> > -        #define MEMORY_DEVICE 0x0
> > -    CCLS        = 0x41,
> > -        #define GET_PARTITION_INFO     0x0
> > -        #define GET_LSA       0x2
> > -        #define SET_LSA       0x3
> > -    HEALTH_INFO_ALERTS = 0x42,
> > -        #define GET_ALERT_CONFIG 0x1
> > -        #define SET_ALERT_CONFIG 0x2
> > -    SANITIZE    = 0x44,
> > -        #define OVERWRITE     0x0
> > -        #define SECURE_ERASE  0x1
> > -        #define MEDIA_OPERATIONS 0x2
> > -    PERSISTENT_MEM = 0x45,
> > -        #define GET_SECURITY_STATE     0x0
> > -    MEDIA_AND_POISON = 0x43,
> > -        #define GET_POISON_LIST        0x0
> > -        #define INJECT_POISON          0x1
> > -        #define CLEAR_POISON           0x2
> > -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > -        #define SCAN_MEDIA             0x4
> > -        #define GET_SCAN_MEDIA_RESULTS 0x5
> > -    DCD_CONFIG  = 0x48,
> > -        #define GET_DC_CONFIG          0x0
> > -        #define GET_DYN_CAP_EXT_LIST   0x1
> > -        #define ADD_DYN_CAP_RSP        0x2
> > -        #define RELEASE_DYN_CAP        0x3
> > -    PHYSICAL_SWITCH = 0x51,
> > -        #define IDENTIFY_SWITCH_DEVICE      0x0
> > -        #define GET_PHYSICAL_PORT_STATE     0x1
> > -    TUNNEL = 0x53,
> > -        #define MANAGEMENT_COMMAND     0x0
> > -    MHD = 0x55,
> > -        #define GET_MHD_INFO 0x0
> > -};
> > -
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> >  typedef struct CXLCCIMessage {
> >      uint8_t category;
> > diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> > new file mode 100644
> > index 0000000000..26d3a99e8a
> > --- /dev/null
> > +++ b/include/hw/cxl/cxl_opcodes.h
> > @@ -0,0 +1,64 @@
> > +enum {
> > +    INFOSTAT    = 0x00,
> > +        #define IS_IDENTIFY   0x1
> > +        #define BACKGROUND_OPERATION_STATUS    0x2
> > +        #define GET_RESPONSE_MSG_LIMIT         0x3
> > +        #define SET_RESPONSE_MSG_LIMIT         0x4
> > +        #define BACKGROUND_OPERATION_ABORT     0x5
> > +    EVENTS      = 0x01,
> > +        #define GET_RECORDS   0x0
> > +        #define CLEAR_RECORDS   0x1
> > +        #define GET_INTERRUPT_POLICY   0x2
> > +        #define SET_INTERRUPT_POLICY   0x3
> > +    FIRMWARE_UPDATE = 0x02,
> > +        #define GET_INFO      0x0
> > +        #define TRANSFER      0x1
> > +        #define ACTIVATE      0x2
> > +    TIMESTAMP   = 0x03,
> > +        #define GET           0x0
> > +        #define SET           0x1
> > +    LOGS        = 0x04,
> > +        #define GET_SUPPORTED 0x0
> > +        #define GET_LOG       0x1
> > +        #define GET_LOG_CAPABILITIES   0x2
> > +        #define CLEAR_LOG     0x3
> > +        #define POPULATE_LOG  0x4
> > +    FEATURES    = 0x05,
> > +        #define GET_SUPPORTED 0x0
> > +        #define GET_FEATURE   0x1
> > +        #define SET_FEATURE   0x2
> > +    IDENTIFY    = 0x40,
> > +        #define MEMORY_DEVICE 0x0
> > +    CCLS        = 0x41,
> > +        #define GET_PARTITION_INFO     0x0
> > +        #define GET_LSA       0x2
> > +        #define SET_LSA       0x3
> > +    HEALTH_INFO_ALERTS = 0x42,
> > +        #define GET_ALERT_CONFIG 0x1
> > +        #define SET_ALERT_CONFIG 0x2
> > +    SANITIZE    = 0x44,
> > +        #define OVERWRITE     0x0
> > +        #define SECURE_ERASE  0x1
> > +        #define MEDIA_OPERATIONS 0x2
> > +    PERSISTENT_MEM = 0x45,
> > +        #define GET_SECURITY_STATE     0x0
> > +    MEDIA_AND_POISON = 0x43,
> > +        #define GET_POISON_LIST        0x0
> > +        #define INJECT_POISON          0x1
> > +        #define CLEAR_POISON           0x2
> > +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > +        #define SCAN_MEDIA             0x4
> > +        #define GET_SCAN_MEDIA_RESULTS 0x5
> > +    DCD_CONFIG  = 0x48,
> > +        #define GET_DC_CONFIG          0x0
> > +        #define GET_DYN_CAP_EXT_LIST   0x1
> > +        #define ADD_DYN_CAP_RSP        0x2
> > +        #define RELEASE_DYN_CAP        0x3
> > +    PHYSICAL_SWITCH = 0x51,
> > +        #define IDENTIFY_SWITCH_DEVICE      0x0
> > +        #define GET_PHYSICAL_PORT_STATE     0x1
> > +    TUNNEL = 0x53,
> > +        #define MANAGEMENT_COMMAND     0x0
> > +    MHD = 0x55,
> > +        #define GET_MHD_INFO 0x0
> > +};
> > -- 
> > 2.47.2
> > 
> 
> -- 
> Fan Ni

