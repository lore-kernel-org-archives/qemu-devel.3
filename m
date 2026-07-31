Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEFEC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpo3k-0006tg-Uh; Fri, 31 Jul 2026 10:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpo3h-0006t7-2b
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 10:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpo3f-00022D-MM
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 10:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785507474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtnXACq17l5xDCt2ldY2aqbYBGn1HmpqVYkUR8hOa84=;
 b=WitqigscaOwhWLeahFt0K4yfNmWV4rlKfFnUqw3VFpQECzXZHcP839+B3nxGm5UkwM3L0T
 h5ohqxKilmCqRWKf2ZbzELx9FHPUhT1E6a2QhbJNHmjzMJKUAyZgPdQejWttnyUwaO1zyk
 rFu9opwDuZ9yDrXeyC/OG4Whp5h2pJ0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-MpN8iqF8NymO862tHKyIJg-1; Fri, 31 Jul 2026 10:17:52 -0400
X-MC-Unique: MpN8iqF8NymO862tHKyIJg-1
X-Mimecast-MFC-AGG-ID: MpN8iqF8NymO862tHKyIJg_1785507472
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bff5c7035so19408461cf.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785507472; x=1786112272; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DtnXACq17l5xDCt2ldY2aqbYBGn1HmpqVYkUR8hOa84=;
 b=bNjXH0nmSqfx3vLDW6nYutoMGDM0oDoamfH5MJWRvvn6ngHWZpJP/+pk4vMafVqGNd
 SLuHkJd3e4NA8vBwlZbmqJ38rrcGYVo56d28EXYWh2twett/NvHVotq4r+l7zlGOE/Dc
 zwJGEEdsZIz3GXufY+Ow1+uOlA9E8/7fz2TdvIepbRRDVxRcmzLNZl5gn1cTDViC+d63
 mJrYJerCdTd8pfDCzS3nyMOOy4xl8jLM6RMVqlCAAhHUgZAVf8SHNYGkUggRFXygrGUl
 woVduQs8pNCd515rJrGEwbXymTJcC6q7MbOr3D6/D7q9FYu2AF911hsFBRZ/gaWBuhcX
 z86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785507472; x=1786112272;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DtnXACq17l5xDCt2ldY2aqbYBGn1HmpqVYkUR8hOa84=;
 b=eeNnsmcqrpJBWeQhVC8qaVZpI8fmbhZY1SSAAL9hlspM7bHQPzIP1hVu41TLzh6LF3
 UCmFxldb0q771mQl2SkKkgj/CT+KXlCfOehZ6ssKg0NE34uiNjiKYNVen1sG3F1Nu/Um
 XTbeTZiioYBfbs1SypOBbQApdbL5ZsDDx8M2phxNJJO1Iv65ryKWBDn1twfJBM2Dgrl7
 jppiy/6IK1Eb/nc6OO52hvTCuuU2OtHVMokc5LGN24JcRX5gcrcvrFCp4IWVzD8jNABr
 BMdVel44YjFjalusGooXr9jgt0UW34f6SYlPa3tEGy45cjxFVLXsF0t1D3gucoAp8sYT
 w3YA==
X-Gm-Message-State: AOJu0YzCzrBk4OFpMjK5ShWPGrs7TCnK+zAjvAtADKT/h/tgF14VTxyO
 EKBFewAJhHGrOF6QctA0fIzPo9N8+jnzLyTNYr2QVTn025hVzfJkdSPbEi8OYRrT1bBuXY1WhgA
 efnV0IhZ34G4yu6/Gr0a+2hhyOKfXSUl9MEOiQBArr+jll3rDnReY3hXD
X-Gm-Gg: AR+sD1183jZRsAv2/f2PbHXmQVmyv0atSjwG+aD6PkCq6CM5KKQBpDtmQmNZL2RCgRi
 Bvhn5LtuqD6bHKKzgckds38IDsxfmQ/RQfqpc4Em823YEwmbHUT3ck53Nm+f+Z3KRCnjXzFiMyv
 FHwHXKswXu/RtPReD+hTWoiocey/9aDM+Q5J5d8G/RfnemNHabnRXUNZCJxP921NfaWOZfM1iuI
 27aGP4h4X7I70wSKNyXY6Zl22tc3blTBf4D22z0rIWE0xhIpTAOVqPwSaovV0M+3W25eY2lm7bV
 ggDukDrLn2g23jVE3SK+ijZAdPCncsgEtho7SdxWyk3OdImUj9l8dzqeow/FVO8Yx7Io4yz0
X-Received: by 2002:a05:622a:4085:b0:527:7521:3f8 with SMTP id
 d75a77b69052e-52b568070b3mr4544131cf.44.1785507469535; 
 Fri, 31 Jul 2026 07:17:49 -0700 (PDT)
X-Received: by 2002:a05:622a:4085:b0:527:7521:3f8 with SMTP id
 d75a77b69052e-52b568070b3mr4540401cf.44.1785507466883; 
 Fri, 31 Jul 2026 07:17:46 -0700 (PDT)
Received: from x1.local ([2605:8d80:6c28:a264:ecff:d5b4:39f6:3dd5])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52b4eb921f5sm8531241cf.21.2026.07.31.07.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 07:17:46 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:17:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Sam Heney <github@me.samiser.xyz>
Cc: qemu-devel@nongnu.org, farosas@suse.de, qemu-trivial@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration: Only build tls_no_hostname test
 with TASN1
Message-ID: <amyuhgeXLH-xXTp8@x1.local>
References: <5f24de0e-49af-45a7-927f-f79b203bb335@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f24de0e-49af-45a7-927f-f79b203bb335@app.fastmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 30, 2026 at 11:59:44PM +0100, Sam Heney wrote:
> The test_precopy_tcp_tls_no_hostname test and its start hook use
> TestMigrateTLSX509 and migrate_hook_start_tls_x509_common(), which
> are only defined when CONFIG_TASN1 is set. This means building with
> gnutls enabled but libtasn1 unavailable fails:
> 
>   ../tests/qtest/migration/tls-tests.c: In function 'migrate_hook_start_tls_x509_no_host':
>   ../tests/qtest/migration/tls-tests.c:510:5: error: unknown type name 'TestMigrateTLSX509'
> 
> Guard the test with CONFIG_TASN1 like the other x509 tests.
> 
> Fixes: df9c38b19af8 ("tests/qtest/migration: Add a NULL parameters test for TLS")
> Signed-off-by: Sam Heney <github@me.samiser.xyz>

queued, thanks.

-- 
Peter Xu


