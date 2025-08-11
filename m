Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD87CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulYHT-0005xE-NM; Mon, 11 Aug 2025 15:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulYHN-0005v0-PR
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulYHH-00034x-JX
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754940825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54xiyLPjV+CoL+z2hkhIwfQ9LXO+J3/3nU7iVckxdcQ=;
 b=hqWmZ/FRjAwdu/dsOtzSYJZjug9pnEsQFm5cYsbCMa2H+dvzBDGNo5pj2S6KmKa89wO1BZ
 76wvkSthScMezAQwAgjUjNtrHJl4y7UaOItX/OwrkXIT6hn/btAYiYRnaUJQAO4KSr3F1m
 h99Zg1CAE9Ny3Eimf6PQVnKcruwLWpM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-PJRStvFEN0eNHcxE3bYLSA-1; Mon, 11 Aug 2025 15:33:43 -0400
X-MC-Unique: PJRStvFEN0eNHcxE3bYLSA-1
X-Mimecast-MFC-AGG-ID: PJRStvFEN0eNHcxE3bYLSA_1754940823
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e667b614ecso1014124885a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 12:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754940823; x=1755545623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54xiyLPjV+CoL+z2hkhIwfQ9LXO+J3/3nU7iVckxdcQ=;
 b=BKhoDSt7AITFWOpo/ovs4jkJYAVcSge3tyD7EfeL6/2BZAmkYyMACkPgoPm0RyaIvZ
 Q5IcMS5X2HtJaLj+0gUyTPE67ECGLeMHlFbEni+g1AdUFLRH5hbDd21g0pvpaYjysW+M
 OIS02CNuqUWs7N8jhYBBkjL1LnkUqDuTBefrtGkfkQ6AapEyhm8D7XCFCV5QrNLuNPN7
 prB8y5FMoPEHy1sAhGipMTaNoduQjAju1qi45FGEQzFSzk4ZGx6MDi49M2vD/CISy5WE
 XIGFWCtQvs0qRQNcROtWvEb8fkjbHBRcjpw59eYcMWLzD8L90GrQxQK//UGLw+y8O3QB
 RSQA==
X-Gm-Message-State: AOJu0YwapGOV7uiEnEYbxcOnAC9IE4SLBpsLmUTpNc+fnhzVuP+BoiyV
 +7ycsJbDWnGcbS0FQ6jtDxcJqshi6l/x46fyYCIrS785E3Frd5VZOwknShzwIAWfdIw4zBaxg1g
 2+0tyd+XXGsd8c+7H92OQHZpq/C/gmtI2ZzFJ7MRJQsCo0YZ5wX3t5Pk2
X-Gm-Gg: ASbGncvRGNwMIJZmHlEoWpCsEZg3JQfJIj6/0jedMX8BRtTBIQyeSq7oSTpd2lO6sl+
 ZqkKg42GCb43IQXMzN3Ik4CR8Er41NMkItKGyx3DTVztXfafXFjmcnGHiAyVYvdmLOAFNQjFXIh
 9LKQ/0UM7oVj9qxGugGTINtBNDblZJBtmymA0mRe5dvd+cvjiytk8Vx7yXmBWDlLP6kVBu8aZz0
 +ldFvyPjqvtFFq5qFVRM8oCNB4Xa4Ta8dXfQ58q/WPKc9CkecgTuMCfoNHWw3/hbQ6EcmtwPVri
 vhwBP1JeAx3aMW0M84vh6yg0C/be182/Bp5PGdEp8+8kmrexo3TaFPMnP8sEfrFdT+6tGOvHKD7
 SlHVQebLFzv6ItAhMmSxMfA==
X-Received: by 2002:a05:620a:6125:b0:7e6:604f:f747 with SMTP id
 af79cd13be357-7e8588e0cf5mr134578685a.63.1754940820683; 
 Mon, 11 Aug 2025 12:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFarrCvuV8wPYK/qhy24DbEAJJ0AP6S9pRcvGEmVqd0FIDfQsBkXJ3TUFjN5DdAATvVJ2k34Q==
X-Received: by 2002:a05:620a:6125:b0:7e6:604f:f747 with SMTP id
 af79cd13be357-7e8588e0cf5mr134572785a.63.1754940819847; 
 Mon, 11 Aug 2025 12:33:39 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f72950csm1596171585a.65.2025.08.11.12.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:33:39 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:33:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com,
	richard.henderson@linaro.org
Subject: Re: [PATCH 3/8] accel: use atomic accesses for exit_request
Message-ID: <aJpFjHUP870sVr_O@x1.local>
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808185905.62776-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 08, 2025 at 08:59:00PM +0200, Paolo Bonzini wrote:
> CPU threads write exit_request as a "note to self" that they need to
> go out to a slow path.  This write happens out of the BQL and can be
> a data race with another threads' cpu_exit(); use atomic accesses
> consistently.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


