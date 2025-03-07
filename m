Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38950C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 23:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgnj-0002LK-0M; Fri, 07 Mar 2025 18:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqgng-0002Kk-N7
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 18:08:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tqgne-0001qS-PY
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 18:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741388892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k10iL9BmsENp5Okg8dtuC8wct75aAGwF24DUKyEVy14=;
 b=iC+OyTDgVEQ4irQDaLWTxO/uT5tpaPQ5eqVQlKcentQ26D9RlQQDShgddfrTFwlLRp3CCG
 WMtpi01uTPOn1nUgJKwHnDGo1ObZ7/fheU9Nok0FcOXzzzZAu3VUy0QE6zzWpnlULY+KM8
 jm262+lOifwydQq5LvrLEpyiRQkpvWs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-1qGbegCsObiK1GekywBb3A-1; Fri, 07 Mar 2025 18:08:09 -0500
X-MC-Unique: 1qGbegCsObiK1GekywBb3A-1
X-Mimecast-MFC-AGG-ID: 1qGbegCsObiK1GekywBb3A_1741388889
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c0b9242877so595097785a.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 15:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741388889; x=1741993689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k10iL9BmsENp5Okg8dtuC8wct75aAGwF24DUKyEVy14=;
 b=YGBR4fRdNCd2PjoyLEMgOrFKdaGaaz1AlCkoh+nzzRRgfd0lb2tsYq1SHkLAwq7Ew1
 yrqn75VO1fNbst62qut61ABhef8DXQA9DZiIiQjzRBkZ9Zwi7kHkvlDa4Y6BkqD29Kii
 7iKARldChpXX3l2BYM8adKE/lAKAGeDVwUvE0FNlmq7+2Lo7lx+m8jGdtCr/MxYrsXQp
 5qgOqiql2U+yuKdU4L4ww/ydDsKWFljDbrNH8XOMeU5B5VLpQmgmXH4CiAXy7zYjhc61
 knWVk/g3H/XjebdHN8FL5ZsCLeywRRBi1r1FsFnzIMojPJHqbv76XmgLHdnyAA8HVbaB
 ENOA==
X-Gm-Message-State: AOJu0YzHsTBxe13b7473LArqU5GIJT/FHUaDAaCvTAQnEdT+NDmyRzbu
 ZexeHDMRTz4PvN5id6wFKLi23yW/A2ARlMXsd13aeIHSqFMdumMpUY9a/UZ/5GN+GaZkzyYJqRV
 DqNupafL/UYJ+ZvYGB5NQKQiUvKUBwit0Yy59XMAjIpUvmrYnkFRz
X-Gm-Gg: ASbGncvE3C3iEMi5TThZBwTqCIext21GQvcHfVVpKSSNW5wcpwIb+GFcI7wNOEgvjXr
 HsG2H2wR2b55me1iQCxaFdckrGaotFz0HS698I8PCN6pYshPqIgHFICgpYkzxYkJ3HK7nt8gs/8
 QI18PdCn9hNdPmaPg/LChf75PX2oAdhoS+mdw2sD9DJu+SpXEZ7jr6j2tIZYdJW1h+CU1SrJAvX
 3cLQXen2Ts5MSnGSeBKW2inCFPlO3DFc5REIfMZ1L42GXk/PWDQ97s6VRIt9ZzXCcQv+3xaKFgr
 vZHZ7qo=
X-Received: by 2002:a05:620a:6282:b0:7c0:c201:1e0b with SMTP id
 af79cd13be357-7c4e24dadedmr730719385a.17.1741388889391; 
 Fri, 07 Mar 2025 15:08:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWRFijNlyU120KV1DpjvzaoTJe1MBaChADIis9RTTyS2IJhTqrNfy9vlqx8tGGTgSwEjNeTw==
X-Received: by 2002:a05:620a:6282:b0:7c0:c201:1e0b with SMTP id
 af79cd13be357-7c4e24dadedmr730716685a.17.1741388889174; 
 Fri, 07 Mar 2025 15:08:09 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c3e534d38dsm301754785a.44.2025.03.07.15.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 15:08:08 -0800 (PST)
Date: Fri, 7 Mar 2025 18:08:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V1 1/4] migration: cpr_is_incoming
Message-ID: <Z8t8VbFIj60gUDMI@x1.local>
References: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
 <1741380954-341079-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1741380954-341079-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Mar 07, 2025 at 12:55:51PM -0800, Steve Sistare wrote:
> Define the cpr_is_incoming helper, to be used in several cpr fix patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


