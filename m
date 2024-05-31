Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F12C25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0By-0007XS-G9; Fri, 31 May 2024 07:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0Bv-0007Wo-Tz
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0Bs-0001XN-4A
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717153975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJ8KNJuQJ+2POJtaJdqo9IYMUJVBojTDcmu1dLhG5/g=;
 b=JrHDG4pWayMyAVdcWLZ3Pc5U+Ojjep+mybbNeLCKFTwtBF10ptT01UMf3xXHDnotdwCN5a
 d2ICRk3tQKK0YDk37sn4HQQ6oV4nQQ3nli9KcIy5TpLAG3bdirHIeXa+0H03MnuQuBTneO
 UhhpFko4+lOUmsecNrIe5wml530jGAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-XoXK_ED8O8eq6U5exz82dA-1; Fri, 31 May 2024 07:12:52 -0400
X-MC-Unique: XoXK_ED8O8eq6U5exz82dA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35dbf83bb20so1155707f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717153970; x=1717758770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJ8KNJuQJ+2POJtaJdqo9IYMUJVBojTDcmu1dLhG5/g=;
 b=VCTIO+cnl1GaN2Wn2i78fGfiLq7k5NnubAGr7NREofGVcz0QonN2xVmFx5DgiMAgu6
 +nRJnbLsDfvtQf7g3y8zylWRZNWvxVsZhBc5+t8eUmB85QKFcCZ8mnTkEkT5HvDfjb52
 6zGoRBnQprlIMjRTa081ab7/GGbXBPPW0dV73l5fGJvP6ylYk8uSg5Yvo9uqgDsJC+ve
 LCSEYgNDeqpiAEu2jev9sIU5yu23No+YBApbQcYy4YBOtoIAH+/hAWpC1tmbp3M38CN7
 nesb0XzxaCFZZp6w5oy27FwQD8RJfOEsDbbw+n9DkZmvi9bUkoCN4avlNRZDZMdqP3mX
 uyPg==
X-Gm-Message-State: AOJu0YwHWUtZl29sXNi/G/erf/LJfEl+sUftqwwgYYNpI71nylyR9eAS
 BNxC5ozqvDl228d57wOOTfN08rwu8NWi7ZolfUI4oxXWrbyXb+RYB475ZzZnM30jNZecNheSfli
 wEzkrg5O5Ow5NdKD/X6f0yuKfAtPiN5sTN9ZZZNJ48480HhixgL6uO4gCdIvqPOyBsk/hxO6w2k
 hY7c/fg1eEy7WgsKczMvIOZuwoVvs=
X-Received: by 2002:a5d:564d:0:b0:35d:bf85:6c22 with SMTP id
 ffacd0b85a97d-35e0f2a9c7emr1149866f8f.40.1717153970755; 
 Fri, 31 May 2024 04:12:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGog+TbeCSMiKXPakxXxwYkTPqV+yPkF9xg8OZpS7HS1g3M3JCYHKIlLUmBtphO07AyegEKBb54FKFWn7U9Kmo=
X-Received: by 2002:a5d:564d:0:b0:35d:bf85:6c22 with SMTP id
 ffacd0b85a97d-35e0f2a9c7emr1149841f8f.40.1717153970338; Fri, 31 May 2024
 04:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-23-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-23-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:12:39 +0200
Message-ID: <CABgObfbBGmZR98zDiXDDpw_K=k=4EoFhBtYT03ghDiv+HR_dwg@mail.gmail.com>
Subject: Re: [PATCH v4 22/31] i386/sev: Reorder struct declarations
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
>
> From: Dov Murik <dovmurik@linux.ibm.com>
>
> Move the declaration of PaddedSevHashTable before SevSnpGuest so
> we can add a new such field to the latter.

> No functional change intended.
>
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> ---
>  target/i386/sev.c | 56 +++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 831745c02a..1b29fdbc9a 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -45,6 +45,34 @@ OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClas=
s, SEV_COMMON)
>  OBJECT_DECLARE_TYPE(SevGuestState, SevGuestStateClass, SEV_GUEST)
>  OBJECT_DECLARE_TYPE(SevSnpGuestState, SevSnpGuestStateClass, SEV_SNP_GUE=
ST)
>
> +/* hard code sha256 digest size */
> +#define HASH_SIZE 32
> +
> +typedef struct QEMU_PACKED SevHashTableEntry {
> +    QemuUUID guid;
> +    uint16_t len;
> +    uint8_t hash[HASH_SIZE];
> +} SevHashTableEntry;
> +
> +typedef struct QEMU_PACKED SevHashTable {
> +    QemuUUID guid;
> +    uint16_t len;
> +    SevHashTableEntry cmdline;
> +    SevHashTableEntry initrd;
> +    SevHashTableEntry kernel;
> +} SevHashTable;
> +
> +/*
> + * Data encrypted by sev_encrypt_flash() must be padded to a multiple of
> + * 16 bytes.
> + */
> +typedef struct QEMU_PACKED PaddedSevHashTable {
> +    SevHashTable ht;
> +    uint8_t padding[ROUND_UP(sizeof(SevHashTable), 16) - sizeof(SevHashT=
able)];
> +} PaddedSevHashTable;
> +
> +QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 !=3D 0);

Please move also the following lines (SevInfoBlock,
SevHashTableDescriptor and the GUIDs) as they are related.

Paolo


