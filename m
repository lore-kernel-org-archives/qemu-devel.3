Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4161D609D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYEg-00042c-Nz; Tue, 16 Dec 2025 11:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVYEc-00042F-Hg
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 11:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVYEW-0000ac-Iv
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 11:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765903743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQYto+lFLUaRNQ5MHVgjg6JS4JEUCEFTZLVGBe7wto4=;
 b=S2ZXXSeD8vo+72dRR/9FfdtrTtFi+uTM92Uy7MCdxSL7tVVsFyLxGlVlE+VmR9QZ1U6SGl
 O2H602nt4N5tVoU8KoZHgumT2dc7JrF+E28soIRwzLRiLZ+kO7l02lqSxBSmE0Balic38e
 eYLlIghtK7dDsDe54q+haHzsXf1PZpU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-AdjtyVN7N56gKdv0FgDM7w-1; Tue, 16 Dec 2025 11:49:02 -0500
X-MC-Unique: AdjtyVN7N56gKdv0FgDM7w-1
X-Mimecast-MFC-AGG-ID: AdjtyVN7N56gKdv0FgDM7w_1765903741
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ed782d4c7dso82780661cf.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 08:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765903741; x=1766508541; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gQYto+lFLUaRNQ5MHVgjg6JS4JEUCEFTZLVGBe7wto4=;
 b=nZxVOWuDKdyGoA1lvaH2n1mLJfpPLux9qV9DU8rKciRLenCJHJ58myqTbEK3kWZfJJ
 x38PfMsHit6WxcvanAiFBEdoHS1z+u6LB9un6oVEBB0DMOr+ccR0N14X3sHrpZNPy2Z2
 8mrdXDKdQCMVoNFZX+J4Nsens7HT7piIOred2WaFkk860gOjeE0H/QLzi+Q4nQZ5KdQ1
 YjE6nF2md8VPDXxJ81oKSMeT9QkszIQRgvgvYU7SuEUhyd7fDzvnDA9xSmni2NV9TGGs
 icJpRfeocdf6/pICI6CfBUeOTDAFv9gthJlcKZ4Pl6slZbEcd/MaDNfuFpwjVsKPVY0b
 1pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765903741; x=1766508541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQYto+lFLUaRNQ5MHVgjg6JS4JEUCEFTZLVGBe7wto4=;
 b=XOLgrwo22dyhUD2wX5E18jOMt/B41Y8F2spfU+83PxXl11N2dDyReOl1n9tG8XA498
 M8sE7gJFYaZ1HOxN7eEid3RBerjKhDCnm6sPi9Tbp+yLRjcLIOD1hKgaRedOMCoOn/8I
 gpT0B0Ue8b0IHV1ef1U801xPbgou+/VO0+VTcn32JvwhoRxSwRqgoh8ivx7hQzRlO4Xd
 vtHKuyKzsQKGi8kgCvQnFrHQIYsoLUXj8nGItzgcsTsMnI034dKzm6VLgpkVHOinatdM
 A1jirR3wUE4YEqwMKQmbbOKQfIcJ4Ls/NoBxTSuOpwOyNJMlN1F6/s6G1lofB4JAjMcv
 3mMA==
X-Gm-Message-State: AOJu0YyWj/vm5VNEGwgnU2Rcclw1tthbqu6NT1jxjFxGhn+DwuGfIQ9g
 2iLeatQjOT3JM31AV2kNsXiRvKbKhtIRtgBs0TIzIRWDkXWDYVfY7CA/LfVgHDrIN+3eFyYErIp
 Lkt0WJTq2cN/OrUvNdJxhTb28zgDxO0j3vzNwY9soF985hb2cjYZn2i/a
X-Gm-Gg: AY/fxX5GuE2cY+kyQEoq5Y/cZUvQOArSBqrUY+5Wn/XTchmosuamW92RM/1cxHqC1e6
 m871ilJ5PI5tNboB2M8fU/hAxIsZw3/IYn5tnvz5GzR2n2GEs4lHmZf3VDKpv2/kVDzcO+Ck69b
 Qoov295LLSTCycJvQT7FbAmsskQQIvIEhXnoak2OSI8ZimsxnH+zk5Sr8HVPPs/Mv8912fW7v0D
 Z7rFFYWj0x5phES84FZUzuhXrvmbvug7BIRQvEWGBuc43RcVwOCgFYMklOLi02eKKw2owKX45e8
 QoTi3SX5QUculZ3tU710hFIvpl1YRo7jEA/LYmYZUwcvpbFtcOOTMhwWyDOsw7ea1jg9EkXpt4l
 /jog=
X-Received: by 2002:a05:622a:1c0e:b0:4ed:d76f:a357 with SMTP id
 d75a77b69052e-4f1d059f37amr220703681cf.49.1765903741466; 
 Tue, 16 Dec 2025 08:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCyHgugoTKFgo1DpHMvs8oFSAGLMIPTQdSr+uCAn6CXPOuSn+eZgu6N0xDW53aJsLl6xWa4w==
X-Received: by 2002:a05:622a:1c0e:b0:4ed:d76f:a357 with SMTP id
 d75a77b69052e-4f1d059f37amr220703371cf.49.1765903741061; 
 Tue, 16 Dec 2025 08:49:01 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f345c5bf4dsm19574781cf.28.2025.12.16.08.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 08:49:00 -0800 (PST)
Date: Tue, 16 Dec 2025 11:48:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 02/51] migration: Fix leak of cpr_exec_command
Message-ID: <aUGNe0ffDbqj995t@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-3-farosas@suse.de>
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

On Mon, Dec 15, 2025 at 06:59:48PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


