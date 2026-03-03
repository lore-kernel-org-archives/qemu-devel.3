Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320B2EDEBE5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUyc-0002y9-Lq; Tue, 03 Mar 2026 14:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUya-0002tQ-RE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:00:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUyZ-0003cO-A2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772564410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/+HIjwU2bq3jhg1CvjUzjoo9A1v9LPZDGHrJumMhbQ=;
 b=QWRT7xJP/Pj7qOTUx/d9OtM47VuCiL846pt8vChwfOAEdJCw05U3Ellbw/RTZX+5JSb1uO
 IvkhSUsuo51nJaMHg5ShCFidDAIcoJQvLi/YQCTu8Iugvsho+VX4y+a5Ar2jNpb1qRDxXc
 Wu+mxzVA7vy73Ypq6B7Lm1OvrE1nYw0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-9WNnKr8QO0mfO4Rvwq-ytA-1; Tue, 03 Mar 2026 14:00:09 -0500
X-MC-Unique: 9WNnKr8QO0mfO4Rvwq-ytA-1
X-Mimecast-MFC-AGG-ID: 9WNnKr8QO0mfO4Rvwq-ytA_1772564409
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c71655aa11so5845012585a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772564409; x=1773169209; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j/+HIjwU2bq3jhg1CvjUzjoo9A1v9LPZDGHrJumMhbQ=;
 b=A46R2kZ54OmATv3EZLNYZSZ/cNHVBIvdkis1BZwNErGp01LZ3oAFJ3Joif6W8rXBgC
 V8XGaEZCFNtqX2cfS2VdZz2Va+ZqOXtytElCkKdKYwvPP8hCdxw2pBRqEkzUBXPvt9k5
 lcdBKn8J7TY1Pw2pJ/Wae2dEhu0iEX59PsWsXXwKw2i6k+8y6rAwzERTX+6EbE3pIw2P
 ZowSbAuifw7WeB2hcr7TfSWBu1BKISgUiAYAa3YJUYRbwqOXwGfb7I+Gc1yVdlUuTxZc
 fIoUfRZTmfGBXqwfJkDV322DY6W6LB49F2PJ1gNj6a0b7QRxyzewcB4/ukmMnOMiLaL1
 EURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564409; x=1773169209;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/+HIjwU2bq3jhg1CvjUzjoo9A1v9LPZDGHrJumMhbQ=;
 b=RW8gTU6NRCaMqt/JHr/83ZhOy1J4BBPb8PiUJJwgvONPUddEINehgBWfDzLWkBF8Av
 xhaBPorx+X4XLrkRgPEvGRsVOd1oOgJkjfeA78PO5BSGpSWb8HAwkKqibgnYgWQmKIbK
 VLpQy7gcoial2x/z257TBoeUH/cZM67jAueDPufCRMivfBAeAvhULTLIflWQ8vcYF7WG
 wPo4axmDPF8591YCH2mhcIXpdW4RUfGyfDl/sS+vr7J/IHeVqvaxpXVhdaitXnxBt0Zd
 7/l5rpEBfpwd6Z8VVJTWNoY4ICB+nvk403kbKzBP2Mp7ZoxgjqX0Tp22XbVB/8+Kb6YR
 Qq3Q==
X-Gm-Message-State: AOJu0Yzl8+h/pXXvDO1omv1cdT7X2F7xn2WXs0L6e+wzZa3zBaepHWid
 mddL/mYm7L4XgT61SZKjdGv8026i1XQSfl5X82p3hRczV26CQZUdoZoXoVHWMLVR3FwLBOfVmc5
 wZTKWn37E99rfErHgrn816V1c9PniX5vgGNRtbXFE4/iwMnF1WgboXvCi
X-Gm-Gg: ATEYQzwSCY46Gf7KTtdHai6MY9RaPum2m/x6c/Nqeocgba6k6QWnLmZa3p8WLH7Qd68
 vqq+Le3hsK2RBLAopWtlRIa6NOkUagM/eA6d9eynAxFSQBFvq003tOCoURtG9gOIaxQNBQGw5lk
 Tj0KcbrPsGj4OMLGNlSqLNQrvANTLGnBLkhtb0JDUBVfuVNFL98pR0YGN8xC9PK90noiTFwmR6k
 SoPHMqYzEavZu4L/AptS4DJdHriO3FROg0Pk453HhJiViKwK9Q3bXYFwcFnTcnlJU0uqjKzeX6/
 7ttKWhon3w+GuPEQB8Lee9JpYt0zj9xBTh1qQSWeNAwHAP7sVS2YpjGUEiScMgF/WtH6/QJxuOZ
 Ej9ZSpNTKbwGUtg==
X-Received: by 2002:a05:620a:190b:b0:8b2:e9e1:400f with SMTP id
 af79cd13be357-8cbc8dc28bcmr2048400985a.4.1772564408680; 
 Tue, 03 Mar 2026 11:00:08 -0800 (PST)
X-Received: by 2002:a05:620a:190b:b0:8b2:e9e1:400f with SMTP id
 af79cd13be357-8cbc8dc28bcmr2048392085a.4.1772564408097; 
 Tue, 03 Mar 2026 11:00:08 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66f325sm1446922085a.16.2026.03.03.11.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 11:00:07 -0800 (PST)
Date: Tue, 3 Mar 2026 13:59:56 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 05/15] kvm: replace RamDicardManager by the
 RamBlockAttribute
Message-ID: <aacvrMdONqbDD_nP@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-6-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 02:59:50PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> No need to cast through the RamDiscardManager interface, use the
> RamBlock already retrieved. Makes it more direct and readable, and allow
> further refactoring to make RamDiscardManager an aggregator object in
> the following patches.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


