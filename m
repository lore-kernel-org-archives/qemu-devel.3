Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F5606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YKK1SeWh;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HMuKdrQe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRwF-0002as-Uu; Wed, 21 Oct 2026 04:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xJRwD-0002ak-Pu
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xJRwB-0001Ev-O1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792572282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyrchWQSFPcfIb1nuIaz+FTi4c4gDyHNCPbzxr5IDRA=;
 b=YKK1SeWhMpB5waKpQp/UCiuY9ylsyFiWte06BkX8f4MBOyd36NPC8JIm2vOn7y0qFFXIBN
 9WUYo459kFU9eLzPyTr37jUg5paNLS/OYe93M6rhFSGYxIEMUkbzlOhDdhj6jrk0a5lBdE
 t3DTm9Rk7zlxWza6NcTe7OReV58+3Q0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-q-HjEuM3P1aGzLxdT-5RZA-1; Wed, 21 Oct 2026 04:44:40 -0400
X-MC-Unique: q-HjEuM3P1aGzLxdT-5RZA-1
X-Mimecast-MFC-AGG-ID: q-HjEuM3P1aGzLxdT-5RZA_1792572279
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e29c25101so47615f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792572279; x=1793177079; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TyrchWQSFPcfIb1nuIaz+FTi4c4gDyHNCPbzxr5IDRA=;
 b=HMuKdrQeI7NAYs1+mdN5dMed+QMuXOS7VcP55hFmZwunJ+ZTlaYWENE7lr9Eug53Ig
 P5ZcCsVxpKMGvMD4qOxAlK/2GUpjtgwn3WofSyt7bUI9hELI3TrravTxMKZsOCgxAvJ3
 bhkWMlCg9GK0kz9DWcGkctLvE4iETJoKE8o+X2bEckrdzjjyePpa7DmLzoEfJkDW/7xG
 ux3hbIkwhrlIW9/vvysp2tnYwmw4pGYjC3MPEJSS9l0RNf3lThAX8oHD6qXsKDxuYra4
 l8AicFb7/LOP9Ca76b9+OmJRyBOlWYq8CJ7KxbLyYad2WamdNs1s2g+jzK70xp7Rz/IE
 sYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572279; x=1793177079;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TyrchWQSFPcfIb1nuIaz+FTi4c4gDyHNCPbzxr5IDRA=;
 b=gTW3BKD9UUcrneVdvMhthZZWsq3SYGeyoc/oboKLg/hqVggDi/ao0cHTcHQXPA8/bp
 nu/zmY6B1zoZIimKVJT2ae5ppmBQe9rSr15Rhalchy2qdxcvCe3b0oB8AeeWodA84KLq
 Hc5G+gQGL4EALQwuDlUgGcp4pVXJnyRG2kzILh4Dc2E78lvd9Dyeq+/gaUe4iopmU35R
 ZffAJTL+yBqiDh2KE6cirl7nId7vnF5CP9x2IOowwOIRY8NWKjqcyd/fdgns/1d9Juqb
 VUQDEiJPsTVovDen5LIMJtymSTn1++EUuTjrDR8XGRjuUXDU8sUDKWIMB6m/HlT5oJi3
 KzUA==
X-Gm-Message-State: AFq9FYJuN4jZmwHAlSs2WvGIANxxDGhbLWm3DY6RlRq9GcE2lxa+HzmT
 SC4LnaqkRa5QjiyNI0i74akoZDeYlloO7iGsnkqb24gEKHYWbHmMB+4Fk4idoFIRLVhLTK+kEJB
 HVmv4hU6Lol4X0Iv1g10vKfYR9oN9xy6qohK3ukpl3+3YUkQriz7bGLVX
X-Gm-Gg: AYBFou1eDBlMrW7DK972J0GvYYcQIhhW37eHm8+BBo1FryDJolEhA5LSWFRND8bvgoj
 VElOWbAH7mPRluQEfywkCUH3fIiuocog37f7+lV2yA4WW12G8iIHucGZdKiNZ17wFvVGpgrkU+Q
 aQRlq2TCONjGpa2Nmu1hRQ11UbPmZodQ73tllIOxGtnmK3V2/lHpkGH0wbwynKtc5u5qf0xXaCM
 /74DROgilkRd3oASN9HO6xQQrjBDwq1QjHw1q8kviKW0vtS4WmO2++j7YN+r4Cor9jtUgnZZuXG
 OX2UKf2uWFwDVsJ2cBi+UVwixk1L4FZgX9F+OWoTaTJ7NcdsEiozfauMpewc3rel76FX9ou2jEs
 ifVE=
X-Received: by 2002:a05:600c:1c1c:b0:4a1:d307:d578 with SMTP id
 5b1f17b1804b1-4a1fdb20a75mr25640455e9.11.1792572278734; 
 Wed, 21 Oct 2026 01:44:38 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1c:b0:4a1:d307:d578 with SMTP id
 5b1f17b1804b1-4a1fdb20a75mr25639725e9.11.1792572277907; 
 Wed, 21 Oct 2026 01:44:37 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.165.64])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d85a9bsm152638455e9.15.2026.10.21.01.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 01:44:37 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:42:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v4] scripts/checkpatch: validate Fixes: tag format and
 commit ancestry
Message-ID: <CAGxU2F7g2S1hfpp=_u1LkLBE=brkCFvetjtHA669LtihjZANHQ@mail.gmail.com>
References: <20260806171333.328864-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806171333.328864-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cédric,

On Thu, 6 Aug 2026 at 19:15, Cédric Le Goater <clg@redhat.com> wrote:
>
> Adapt the kernel's checkpatch Fixes: tag validation for QEMU.
>
> Add a git_commit_info() helper to resolve commit hashes and validate
> the Fixes: tag in commit messages. The canonical form is:
>
>   Fixes: <12+ chars of sha1> ("<title line>")
>
> The check validates capitalization, spacing, hash length, lowercase
> hex, and quoted title. When the format is wrong and the commit can
> be resolved, suggest the corrected Fixes: line.

I had this strange suggestion while checking a patch I just sent[1] 
applied on master (with this commit merged):

$ ./scripts/checkpatch.pl --branch master..HEAD --codespell
WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")'
#19:
    Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")

total: 0 errors, 1 warnings, 21 lines checked

Commit bfd67b5941a3 (backends/igvm: fix parameter area entries leak) has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.


An LLM suggested this and fixed the issue on my side:

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5df266acb1..82f62f6021 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1889,7 +1889,7 @@ sub process {
 
                        if ($line !~ /^\s*Fixes:\s+CVE/i) {
                                my $tag_case = not ($tag eq "Fixes:");
-                               my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
+                               my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);
                                my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
                                my $id_case = not ($orig_commit !~ /[A-F]/);

Since I don't know perl at all, please check it and feel free to submit 
this change or another ;-)

Thanks,
Stefano

[1] 
https://lore.kernel.org/qemu-devel/20261021082459.72038-1-sgarzare@redhat.com/T/#u


