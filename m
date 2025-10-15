Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57E8CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96EP-0001vQ-5f; Wed, 15 Oct 2025 14:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v96EN-0001v8-Hn
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v96EK-00021G-24
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760552884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3N9SoF8rnYS45zKamyb8oZ7qYpMbrEbIHAArItVIKOU=;
 b=Mp3GnMk1mHLp9t3rvV1PQTRMBW6m1IlBG5Pt2B/EiqqAPBMb8jvHGHRNQ3ydt3V2s7YgyV
 PwDsDg0d1aGHoHGrWGU9PpSprnBDApydQ15VAdXpjzaYnOun/CO8kTP6ZnqXWWNSiOocjP
 FmTzJ/EW6c/Gb16HX8xk9PrJG5IMIy4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-bC5AyCucMHuCr73ZQOBRPg-1; Wed, 15 Oct 2025 14:28:02 -0400
X-MC-Unique: bC5AyCucMHuCr73ZQOBRPg-1
X-Mimecast-MFC-AGG-ID: bC5AyCucMHuCr73ZQOBRPg_1760552882
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78e5b6f1296so303179296d6.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552882; x=1761157682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3N9SoF8rnYS45zKamyb8oZ7qYpMbrEbIHAArItVIKOU=;
 b=WfYYzH3YpUiqlK5M4iL+NS1JofhtaeTKtX+LbTQiLR24by5W1/yYyVcoSSlfgUEIFx
 c1Izy1qhtcI5ESElXpBf8oHBvffMQrUqD3TtcOJjvXECwnbhZkcfxz8qAF5DvCEBV0ty
 THddRDymUEJMP81FLKJastl534k6TFaL01h/myDQNpveAxKOC+LSdXvZEN9XRZz6uIcI
 2MVBAAoEBZ/PLplLVNIf1MhnXMzanW5hxoWFn+LPAIcqcrM2tNXVnzj7m8pZWq1csqNC
 qIx12h/p/dFaqDQYh7MfdDl9elksM+11X698RP4160lfsV0MKdfCbNjM74zIwxnOJJNA
 7I0g==
X-Gm-Message-State: AOJu0YyxwqRhSOdlbuKENhqkt9AQgjOz22mnrFJDReFXxcJKOHpj6c8W
 AWUpzAThe4sxhNjRSOQ8GjnqhVszHsUlptN9VpjIgOv3jrzAo0JAKvFPLlJgS2HwyWFF7XFWbQ6
 OhNQN5+g94qu56HbGqdTkfQv4iZNPCW6kN+1D4yJPiWGSCLdiLgo3bEDc
X-Gm-Gg: ASbGncu+F1fbCEobALMZREVg/Q8d+ByHk2wc6z3PgPRUEzgLA8LMgx0Yb3dj+geSn0o
 3A6ZFErwu3nv/HXTxXw8eJpKUzKY+6Ta5MRg1s7S7N5hJ13yMNA+ZFkN/kadGnRdxTtarMn67EO
 brkCZkWoqhUTK6cO3cmd/vQIMkpui2/0bHVx3saRb+MlDxZ9W4zRbpTLfLXwrnS667yVPL3wBSR
 qBca01iaZGa8Gq8t+8JatMBuqY7lJuYMthAfVFW1vvzbBtHwoobJv2dDt82Ml2PRdI1LTCBsVg7
 SqLU56alahncHUhZ07kjMmU++D98iR+H
X-Received: by 2002:a05:622a:7e09:b0:4e6:eb5b:beba with SMTP id
 d75a77b69052e-4e6eb5bd42amr306724501cf.71.1760552882242; 
 Wed, 15 Oct 2025 11:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvy1hT8HDsg+DCbQ4kQqkpJz1AEisZy+eG4HhjLHlJh7t8/K5IvX6v6XktZYv11qd3KjLi4Q==
X-Received: by 2002:a05:622a:7e09:b0:4e6:eb5b:beba with SMTP id
 d75a77b69052e-4e6eb5bd42amr306724311cf.71.1760552881751; 
 Wed, 15 Oct 2025 11:28:01 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e88399f447sm18804921cf.13.2025.10.15.11.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 11:28:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:27:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jmarcin@redhat.com,
 berrange@redhat.com
Subject: Re: [PATCH v2 0/2] migration: Add support for mapped-ram with
 snapshots
Message-ID: <aO_nr3gTlpcxMN9O@x1.local>
References: <20251010115954.1995298-1-Marco.Cavenati@eurecom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010115954.1995298-1-Marco.Cavenati@eurecom.fr>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 10, 2025 at 01:59:52PM +0200, Marco Cavenati wrote:
> Add support for mapped-ram capability in combination with savevm/loadvm
> snapshots.
> 
> v2:
> - Remove unnecessary CONFIG_PREADV ifdef macros
> - Remove trivial doc fix since already queued
> - Fix swapped parameters in handle_zero_mapped_ram calls
> - Check for RUN_STATE_RESTORE_VM before zeoring instead of checking for
> run_state not in [RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE]
> - Check for from >= to instead of from == to in handle_zero_mapped_ram
> - Remove mapped_ram from snapshots incompatible options
> - Rebase on top of 
> Based-on: <20251007184213.5990-1-farosas@suse.de>
> ([RESEND] migration/savevm: Add a compatibility check for capabilities)
> 
> v1:
> https://lore.kernel.org/qemu-devel/20251001161823.2032399-1-Marco.Cavenati@eurecom.fr/
> 
> Thanks for the reviews on v1

queued, thanks.

-- 
Peter Xu


