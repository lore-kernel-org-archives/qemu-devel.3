Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E6ED6ACC0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 11:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGT6-000736-5K; Wed, 27 Nov 2024 06:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGGT3-00072u-Px
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:44:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGGT2-0003El-Gz
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 06:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732707863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TAUTxBdYUVMM2Pa6RSIpUL+Kh7i861DJRG3h2BcSCJc=;
 b=i6jdtTMnvjpr/aHDnuBPTOeQ3bPhsBpkodLX1v4jDjTKjsc96ZGBospwThjK1mWqDNchOg
 /lhaAVIbpIkSGXK/ZqmPjGMRdldUTAlP/Apq17Icv+i+mOCJcBwQjJL+YQRQrkjYOyRJcf
 O0VW7Mho0M/NgSsss8bAo25z63orFLc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Ev13wrCUM9y81jadI0hE6Q-1; Wed, 27 Nov 2024 06:44:17 -0500
X-MC-Unique: Ev13wrCUM9y81jadI0hE6Q-1
X-Mimecast-MFC-AGG-ID: Ev13wrCUM9y81jadI0hE6Q
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3825a721afaso3944648f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 03:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732707853; x=1733312653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TAUTxBdYUVMM2Pa6RSIpUL+Kh7i861DJRG3h2BcSCJc=;
 b=Al41h6uGYNDbmQDgyEFq2xxuJ/hKRcdHfwoTXxFBKc6za1i4m23PHcQKuQiEOCYSQV
 E9bR6uTShpWZ5d2J50+Il0AmOoM/J30iJgcui2kKGivCRiK3ycMk6NMcYoUBhLvZEkvV
 QUPIianOrTNsN/FtGS67hQ+UET4ycD8lqmJGZPwW7hT5DLJa0qE/Xg0KQuvC6AXkSF/e
 Hg4oCXidnsE99f4GnTW4+QV7vcl+fKJOQ4KC45NZsKJsc1vIkUv/6ZJ6nkRUXFdZU4xT
 4cq0GIXem5UJ7TsjRKyhz8uU8+25Gh+9EY0zSaeH7O1rHt5UU0cQahfPhpmvnc42DI0Y
 wSBw==
X-Gm-Message-State: AOJu0YyBeGA0NP17Uu07XfdXbP1LJBgdGrLk9c3PPxxt8hiwUdD0FPSO
 geukFyUIB9M6l/aV+Ty90jBPi0LikPcooZDHEefVZu6Dmq7tWlWv6ASRQog+wX9WjidyIN3g9Fv
 +O7gw8KDejxmK8i/VU430YMz0QLxw2Ks5BPMUDlUJf5iV4F7+N2lrNYwyblknVkmRuIzjEDqyLy
 2za9+CV6bX61s+jCaYewKswfEda2U=
X-Gm-Gg: ASbGnctpWzJvvj7aPcFU8Zlzx5no1nkSAAnvNq3MTP0kq6nDFG6jRR6O836e5htylb4
 ZXrGXWC4n54P0tLzUJ0I6SuLfBT41raBz0w==
X-Received: by 2002:a5d:5f47:0:b0:385:bf55:d650 with SMTP id
 ffacd0b85a97d-385c6eb6906mr1953142f8f.16.1732707852894; 
 Wed, 27 Nov 2024 03:44:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0xge9jKZ+GeaS1DV6phSORDp4oo4hTbOBQC+ouMPR51d8MQcPX2xAZj7x7EGuUeZqxBdsrtX3zO0eWudXnVE=
X-Received: by 2002:a5d:5f47:0:b0:385:bf55:d650 with SMTP id
 ffacd0b85a97d-385c6eb6906mr1953125f8f.16.1732707852619; Wed, 27 Nov 2024
 03:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-3-ppandit@redhat.com>
 <87h67tn1gt.fsf@suse.de>
In-Reply-To: <87h67tn1gt.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 27 Nov 2024 17:13:55 +0530
Message-ID: <CAE8KmOxeRyr7epNUytSp1_v3sCw_tYajSWn5YZQTpjOGXgi1WA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] migration: remove multifd check with postcopy
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 27 Nov 2024 at 02:43, Fabiano Rosas <farosas@suse.de> wrote:
> This should be squashed into patch 4. We don't want to enable what
> doesn't work yet.

* Okay.

Thank you.
---
  - Prasad


