Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41954D637B0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJZl-00040J-7W; Wed, 13 Nov 2024 15:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1tBJZg-0003zq-V0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:02:50 -0500
Received: from esa2.hc2706-39.iphmx.com ([216.71.152.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1tBJZe-0004ZW-PV
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:02:48 -0500
X-CSE-ConnectionGUID: KjR/pAhuQ+udUjmS3moFOA==
X-CSE-MsgGUID: f5x9rwNLTVSIjPaWHKKTpw==
X-IronPort-RemoteIP: 209.85.219.69
X-IronPort-MID: 2631399
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:gp7mH6meXLtkXD9ivrTjPwXo5gzNJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZWm2DO67YZGDwfNpzaYS/oU5U7JXXztBnTAFpqCxnFC4T+ZvOCOrCEkqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9CQ6iOfRAOKhVYYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSsvjrRC9H5qyo5GpB5wdmP5ingXeF/5UrJMNHTU2OByagKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAb+0Teeo5iXBYtQR4/Zwehxrid+
 /0U3XCEcjrFC4WX8Agrv7i0JAklVUFO0OevzXFSKqV/xWWfG5fn66wG4E3boeT0Uwu4aI1D3
 aVwFdwDUvyMr8G0+vWjY+lxv4c+IPTpObhEv3ZO6hiMWJ7KQbibK0nLzdpR3TN1n94XWPiAN
 owWbj1gaBmGaBpKUrsVIMhmzaH42z+lKmwe9gP9SakfugA/yCR41KjrPMD9cMHMSMlI9qqdj
 jiYpD2iU0By2Nq3x2eVo2izoMvzoxjaWrobK52b1cJynwjGroAUIFhMPbehmtGgh0ujHt5SN
 UEQ0iwpq6c06QqsVNaVYvGjiHuNvxpZQsQJVuNkuUeCza3b5wvfDW8BJtJcVOEbWAYNbWRC/
 je0cxnBXlSDbJX9paqhy4qp
IronPort-HdrOrdr: A9a23:XMTysqpiEasPhTW6/f/gTI4aV5raeYIsimQD101hICG9vPbo8f
 xGuM5rqSMc6QxhJU3I/OrrBEDuewK4yXcY2/h0AV7mZniYhILKFvAZ0WKB+UyZJ8SWzIc0vt
 YDT0E9MqyKMbETt7eY3ODSKadY/DDoytHOuc7ui11Ad0VFUZ1B0itOIjqnMyRNNXd7LKt8O5
 yG+MJdqjasPVgRZN+qH2QIUoH4y+EjV6iIXffFPXMaAcW17A9AIYSVcySl4g==
X-Talos-CUID: 9a23:F6U0hWxIjRbpSGhyA3PXBgU3GPpialTd0U6TPkOFC2NSE7iSZ3i5rfY=
X-Talos-MUID: 9a23:w/pfPQk5/wqfqAqpk+Ghdnpsadc5+buILHwzqrQEg8C7FQ9TBy+C2WE=
Received: from mail-qv1-f69.google.com ([209.85.219.69])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2024 15:02:40 -0500
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbf054c552so110776696d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1731528159; x=1732132959; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7V/HGeP9suWz7o0oD66PA6CrQWZiVo+5aHmNG9TzosU=;
 b=WUEAYB3cXZ+qUpg6Vvz72tMrL0OWPyJ2q5YXhcbGTL94IZegqdZf1VH56aX+f0UE7s
 6Czu+D2lIOLEYQtE4kZb9pQcXkndfHZnYIBdscEZZ39rktI6sa8fbqHSkYtmL5UY6jYG
 J3Sri6lt2lZGZVjBTt71D/jZo2UyuZyE78R0bbC+1WYtmNEUu3nPBdajE5Sjv3ZKzceA
 vrxBAU+DfMo2wcvD+beqwtnWWi5Q184PEfpPqhIK6Y+RkMneyMtfJmWEXWWhefrZb4CD
 q/ZBHYoVRigx7UiwQ8eEe/ndhWcc80RDGUNtXQXg1Z1j4kate1Be4GUYc27O70mmx5tR
 jG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731528159; x=1732132959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7V/HGeP9suWz7o0oD66PA6CrQWZiVo+5aHmNG9TzosU=;
 b=Xcn7K3sabBWMdnCTLdArMszuliY+Gj7Bu7HD7qrfLwwinczLCbUNZzs2RkPf8D9YLi
 gNTkCaDp1Dr4baTnNlzPZ7jM8kCxbVvSkUijuCh6MeNlgz4kGNRXocGQy7LgEOkBPSmC
 4wFa/zSbLGBeEs3cFPTtu0AhZguRXnAJ816GgjYjtVZ3eBUm5P7jAFGkqXvkb6IKjLDx
 qRf5BOOxobFhuda1tdmqf0xFXi+g4271cWiqrpiA0zHrUUVgWTglUvPUx4BICphDJ9AD
 TyDcIi4g2F9WQU4zfpUVRmy5Zwit4oCL7CnLa5An750MOubGod84KPNTh8lo4AyJsdEx
 Dwnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV53ugvpZXTKUAjegN9bzEUE2tBgTLR73Detb5kPxzDoStTbKhmqNGuw99KtIpPC6nurU6sQZruLMri@nongnu.org
X-Gm-Message-State: AOJu0YyO3yuSokcdvuPWjMW4yDmke7EyoH3YKqKpPy/2hAiVh8s4odoI
 qxUNeOxxuciEx7VZSpozkGfXinVCPQlsUSdfbRLQaxlKAmJvtkUB31lmoZNrAnLZ5XKHmsxxfVI
 LcjXhCQHimLiAOg9XM0nJz+ekDdtc0QZk3IDFNAqwnKsFC+mbE6cCyh6abWzbie0jRg==
X-Received: by 2002:a0c:f410:0:b0:6cd:feec:32eb with SMTP id
 6a1803df08f44-6d39e197c53mr294531816d6.22.1731528159402; 
 Wed, 13 Nov 2024 12:02:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP4dO9ljs3yrLyUvAlhyd18PcG4Npx/SxuwAZw0aJDm83cQwpBPX+wd0XPdVbXBeVXrTB/rA==
X-Received: by 2002:a0c:f410:0:b0:6cd:feec:32eb with SMTP id
 6a1803df08f44-6d39e197c53mr294531586d6.22.1731528159053; 
 Wed, 13 Nov 2024 12:02:39 -0800 (PST)
Received: from bos-mail01.vrmnet (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3961ecf40sm88392846d6.46.2024.11.13.12.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 12:02:38 -0800 (PST)
Date: Wed, 13 Nov 2024 15:02:34 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe Mathieu-Daud?? <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] fuzz: disable tcg for OSS-Fuzz builds
Message-ID: <glpwzquiqa6vaesu5dg7zc2futxypcycoel7uawlwg6l537oz7@4uzab3435nyf>
References: <20241113163800.355547-1-alxndr@bu.edu>
 <0d1f8f1d-2894-4753-aeef-1a229a71a334@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1f8f1d-2894-4753-aeef-1a229a71a334@linaro.org>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.152.49; envelope-from=alxndr@bu.edu;
 helo=esa2.hc2706-39.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.054, RCVD_IN_MSPIKE_H2=-0.738,
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

On 241113 2040, Philippe Mathieu-Daud?? wrote:
> On 13/11/24 16:37, Alexander Bulekov wrote:
> > OSS-Fuzz builds have been failing due to some strange issues that seem
> > to be related to color codes from libffi:
> > https://oss-fuzz-build-logs.storage.googleapis.com/log-8d5435ee-1677-40af-9656-b4162fa881e1.txt
> > 
> > Disable tcg to disable libffi.
> > 
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >   scripts/oss-fuzz/build.sh | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> > index 7398298173..095f7a90e3 100755
> > --- a/scripts/oss-fuzz/build.sh
> > +++ b/scripts/oss-fuzz/build.sh
> > @@ -65,7 +65,7 @@ mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
> >   # Build once to get the list of dynamic lib paths, and copy them over
> >   ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
> >       --prefix="/opt/qemu-oss-fuzz" \
> > -    --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu"
> > +    --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu" --disable-tcg
> 
> IIUC we are using the QTest 'software [un]accelerator' to fuzz via I/O,
> right?
> Then maybe we can disable all accelerators to speed up build. But please
> mention it in the commit description.
> 

That would be nice, but needs some changes to meson.build, which doesn't
treat qtest as a real accelerator and will complain if building w/o tcg
and kvm:
error('No accelerator available for target @0@'.format(target))


> Regards,
> 
> Phil.

