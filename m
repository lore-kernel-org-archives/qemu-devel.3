Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447F4C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 12:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqA5G-0000Gm-Ox; Thu, 06 Mar 2025 07:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqA5C-0000GL-F4
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:12:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tqA5A-00039U-01
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741263124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3uLVVqhtl2OnmlIBykV2AXDaHLUFcwt5ikFfAirtdY=;
 b=MMWYgOpBHgP+LXsSe0FnAseII9bUgr8b72alMyBJ5EphJo0iddjXErYEN+21C+rx7jLyel
 F+hLhi3mglOq2ydkkSH6gx249xbELcpG5GBxf24hPUSL8cKcI5sn5GzCHx9/hSISX3sSB3
 hUWl4SReB6AS0XZEK7rnNGUWYuWiW+w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-fjsDu-GUP5SjAWYIPiRhfA-1; Thu, 06 Mar 2025 07:12:02 -0500
X-MC-Unique: fjsDu-GUP5SjAWYIPiRhfA-1
X-Mimecast-MFC-AGG-ID: fjsDu-GUP5SjAWYIPiRhfA_1741263122
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390eefb2913so416588f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 04:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741263121; x=1741867921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3uLVVqhtl2OnmlIBykV2AXDaHLUFcwt5ikFfAirtdY=;
 b=srvJtmTQVft/HrJr4xwrsV+e4NaIdbg2Q9PGIQOw3jekjMfuJ37D1AwVgo+0+/Q89m
 KAfA7p1h99BAzyq2P1jec1TbqnGSAEf4S3NZdQNyZwb3Ci8qaPbmh6ih1aE7eEVum1vA
 FR63jSk4Zk9R3jge7ezY4nn7987h2+HtOACCXPN8aFheYAkU1Q9qziaFMlH1CfBkCNo/
 fOWGg+X9FI7f7ldty1Af3osZ8ugUy/YIWYd81hXWtvS3ROIJqb83fiD+eaJTq+P1mvW3
 ma/0th2d2zkmX6v1IePW8ZPDxwDuLhJY32P1/rO2SfoUKVCZiS2E5S3pM9+TCQBBZNNY
 3iXQ==
X-Gm-Message-State: AOJu0YzjTFl+ccIVrdCBw+ALx25m5Q08rjHXpkPzq7njWNBAGCG/8vs7
 sc2ciUotfnmDWTCfbDO03ZJ2SIOIUuG3BmyfUxyjVNxmj47qXy0/FHMqCABjMxUlItbdP0QldZP
 vl6552TJSKslM35hqgh1JEpLLOx2kvCQLr+Ih8Ium0UcatFEW4ElyXrB22FAQEdMkjXq2v/oZ+7
 TDIxCBisdcIBRecXnDKr8y0l2oTXU=
X-Gm-Gg: ASbGncsvkngX98ysXjQHZbejXExmZFagl7CEWRi0R2y2vw9hfmR/EUp5Xq/0y4WrLog
 XWi7c5GFBUjd9tlf+tAGeRkZVksYQ0RhrONnnsygdb8Dg7OBpU70vjJxxUPMMZzpYTEmCDza3
X-Received: by 2002:a05:6000:1546:b0:38d:d0ea:b04c with SMTP id
 ffacd0b85a97d-3911f7bb84fmr6877643f8f.38.1741263120976; 
 Thu, 06 Mar 2025 04:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzdIX8moChDlYv3SMK2btEcMqgaiyO5SakWvLLohdqs38stoj/3YNyE1PJPsM7fxLEY5Pfv+9OA+V64E3wLcs=
X-Received: by 2002:a05:6000:1546:b0:38d:d0ea:b04c with SMTP id
 ffacd0b85a97d-3911f7bb84fmr6877587f8f.38.1741263120107; Thu, 06 Mar 2025
 04:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-2-pbonzini@redhat.com>
 <CAKmqyKPxdUjq1m6C8mZT5Ats3eh01-BMVPAJAdMrOc8foT5mNQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPxdUjq1m6C8mZT5Ats3eh01-BMVPAJAdMrOc8foT5mNQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Mar 2025 13:11:47 +0100
X-Gm-Features: AQ5f1Jpri0dBGlith1x6EvxRcl_RmYnTOeI_-oiyM4E3F416RqEDNNQvbLPev6w
Message-ID: <CABgObfbMjYXZZhEfLH_5k8vxn8zoLh9drWN=Y881yQ7Wcqm9Aw@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/riscv: acpi: only create RHCT MMU entry for
 supported types
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Mar 6, 2025 at 2:13=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Wed, Feb 19, 2025 at 2:58=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > Do not create the RHCT MMU type entry for RV32 CPUs, since it
> > only has definitions for SV39/SV48/SV57.  Likewise, check that
>
> I don't have access to the spec, so I'm going to take your word on this

Thanks for reviewing - the closest thing I found to a spec are two
Google documents linked from
https://github.com/riscv-non-isa/riscv-acpi/issues/16 and
https://github.com/riscv-non-isa/riscv-acpi/issues/18.

In particular, the MMU type documentation can be found at
https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view:

MMU Type (byte length=3D1, byte offset=3D7)
0: Sv39
1: Sv48
2: Sv57
All other values are reserved.

Paolo


