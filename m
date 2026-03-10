Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB68EB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 20:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w03z0-00049P-6D; Tue, 10 Mar 2026 16:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w03yk-00048J-Vc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w03yf-00079u-7C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773175611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yws80lG/tA2VGBUY+xKkheeVjDuB1KjaGVGdn3N3p8M=;
 b=dyoDm2k7IhmCdwlcV4Lg+1TxCLVbGztDc4hqn/mY0w7YBdtBnv3xpGWmP+0o2nTqREmvwL
 z/f4/6GqCIwgDKkh02ER/XcFPtPG23XVIUvpjZgyuVPt8tmCFuRNAAc0/xhNNmoqpls540
 1Xh4cWderQUi0wSeMiBV8MgpftWuRP4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-zkpJtO8INVWz-rrS_l3yuw-1; Tue, 10 Mar 2026 16:46:50 -0400
X-MC-Unique: zkpJtO8INVWz-rrS_l3yuw-1
X-Mimecast-MFC-AGG-ID: zkpJtO8INVWz-rrS_l3yuw_1773175609
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-509011403a7so264384011cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773175609; x=1773780409; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yws80lG/tA2VGBUY+xKkheeVjDuB1KjaGVGdn3N3p8M=;
 b=Nm/5hW9wnCoLKFGqmXf/cxL7urmkRnLMnFSLKl1giN/5IKDmM/69bn/bw89V3K1wBn
 c3JO/OwoQOxhqE8lHnDpClc/1dCsgIdZYiJGOOb/AQ7H3u8eUNp5EYkOwd/2N7m8d8/N
 PsWoVC35lU3cA2GgN9vhFamXHRzm2eHY6ie0QE+HREKRVAATyvB9fYTd1aYJvKOJDLPG
 1Ftjfz4lxYFr5lsqmcPD2o7qV+6iIN5Z+4LriyvGIZBd/99QNqD3btzlv+iFjdqKiktj
 zHNP1dR/6ndqA/97Go+z97FaTR3WevAa1pa2TlCScoz2YjUmICuUhG4qrW+B8vLHDIlX
 9FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175609; x=1773780409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yws80lG/tA2VGBUY+xKkheeVjDuB1KjaGVGdn3N3p8M=;
 b=c2D/cFUTW7loSz8+cNYY5VwMj84AL+sf2+wwMCao6yhb7hpSMVehnWiQigrcX81c8V
 K4GcdXTBA6RQ55LKB6uDDl02HQH5T8swOEPTZEqfjvNVFJOMRBBXwY734dIVmkX+5RBn
 Ixg7gxQDU9YAbIwvszwrEa1r33Xmnz0obs8u0Yi67wQjStPiCVOtXcgT2hzXOnNf2vXk
 X/0zTySk6RaugRLf3MA0jT0lbtUNbMh4OYF/uq5NznTQmyo1+rJkRLnu2FuS4oGp9Hh4
 YbSpZYeotJdB/HunFNtl2mAvHPcnFg+V/uNKT8zsR+dPGKGnGPs68RgbGdRR1iwdLbKd
 2fFg==
X-Gm-Message-State: AOJu0YzyhajlDKM46MrSP+v7rvf+TgZZBN5BunH5klFxR7f3d09bSdGe
 vhtme/lDq+mUj4lS1kOrAqBOSaOEJgs8ki/rlkfRIYGQHpA6MzurbOuwhkYWu9gUR98GUMwgCYG
 yl5WR8m+CVNGN/TQvyfoJ/D8h/KerpsV03VkevmCk6BmE49HyySxDhoE9
X-Gm-Gg: ATEYQzzfaIql0TKypN+t0RS+WWmXTDNEljEOlFRVDZWCGxPbbjGewF/yyGf2MfG18d5
 UKK9jXRCmfCCArGXjBl1+OdANnZCy4F2sUOgKnv0sZrHpQC7n2lVu9gOPtEnN26f676Kk3D7P/n
 dJJa0pwZVoVlIktiudM8JpYGm+j+pKVXVDKepdKGXVyzr6WLkqEI4+4S9/PeHKwkN/bUgrNFLiG
 J4gMsd3Ir8D/2Vw0MyuHW99Ly0mjBL07LPyKKmnpuOcO7JKnYwFUuh30teeIdihvHlbK5ZcF7NH
 ZI6AUqUs5x0xCJsEs5soyKU/rx06AK3/xZh5PkiQGD1ElCNHSsGgL3d1umftXX+C/BlCnnCjoya
 tZJSO+/G270+0ug==
X-Received: by 2002:a05:622a:1183:b0:509:350e:743e with SMTP id
 d75a77b69052e-5093a0da418mr1274911cf.22.1773175609568; 
 Tue, 10 Mar 2026 13:46:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1183:b0:509:350e:743e with SMTP id
 d75a77b69052e-5093a0da418mr1274631cf.22.1773175609131; 
 Tue, 10 Mar 2026 13:46:49 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65beb131sm1499266d6.13.2026.03.10.13.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:46:48 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:46:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7/8] tests/qtest/migration: Fix leak in CPR exec test
Message-ID: <abCDN8YDX8X_A3F-@x1.local>
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310135540.8679-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Tue, Mar 10, 2026 at 10:55:39AM -0300, Fabiano Rosas wrote:
> The string was being dup'ed only to get around the const of the
> qdict_get_str() return value.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


