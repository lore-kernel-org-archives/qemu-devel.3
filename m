Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9919C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 20:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tigJD-0002CR-GR; Thu, 13 Feb 2025 15:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tigJ7-00029x-9T
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 15:59:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tigJ5-0001DL-UE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 15:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739480375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNb+KDU7NrdsoxtJSJthxI/piZRuVCFMVqS9VGMa8GY=;
 b=HRMZBq9/DU+LZ/vcZ9PPT3aiYN3Cn1sWInckbwLNJ0P7RmUwz4zaw/R4mAOUdkW+MuqwdJ
 URpqa0pnTctf2NPGBILw5Y5kyT5/gjqZUTbH/qT26oZXUcxohMp/TOzj9XGKVgkTX+O2EM
 rgy8llcNsZuuJ3e3y2EqCioLN0DPBOk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-WRV0oatFOomSn-OzT18Y7g-1; Thu, 13 Feb 2025 15:59:33 -0500
X-MC-Unique: WRV0oatFOomSn-OzT18Y7g-1
X-Mimecast-MFC-AGG-ID: WRV0oatFOomSn-OzT18Y7g_1739480373
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-726fd020e0dso1073732a34.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 12:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739480373; x=1740085173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNb+KDU7NrdsoxtJSJthxI/piZRuVCFMVqS9VGMa8GY=;
 b=MmMzzJjIfbsc1GkqreAyYSuNbJvcYfctg3F9ODweXmLPvsya7Ayy4ezzdix9GV8/ad
 GLEh90j45bbYiaciCN+hOlYvXxSOCIVDGJd/0I5KnRmCJDD3JgSdKyIvc4Nj0feqIRRO
 dr6HkmTeF0MR+8wrdNyV3EJ5bzpMdQEqN80LYB5WY+Z85aGVSBsvYqyclM1YHZ32SEzs
 cCvHPy4gAP2jul8RZhzHmSw+L083DowN3EznklL0Ff3g+p8PPWUE3DVP1AgAfA88VWLv
 eaYUKBFYl9eyShTwAzggdYHJPRqzY/mZ9o3IYWz2yP/tP5AuyWgHOAP7JGl8ufXOBMTg
 RrpA==
X-Gm-Message-State: AOJu0YypMlpBirPJVtQ6AJqtMXfaxt+nUi8k36OyzlTelkF7k+mEQ5LY
 oRKAIhp4hfikEK1PnnNqWvaKxpes4s8XkUiRrjPjbwtoTYOwjX9kc1lLYauw+GYp3K2w+rVv2o6
 SVGscOj5TGz1Ih/26YJZ/TwxZ3Wvbcrgh1KC211Um2MWd0arOnTvm
X-Gm-Gg: ASbGncsiNh+uomZ22WnpbOljwqdu3FNILGr1N5S5Klls7OyW2fhPJ11Jv5SSbNGphw5
 Eqs44rCUVxwnJM7GexLugA/Um+iRj5tpyoDqrwu3lYTUzBfxXClVXUdkvNaz1yeVqm2qMx7nTNX
 q2gHZBA9Kgk+EsVfdJsSYJz7iauSZfb9E5ZkbIAOG5SE2qxEHUCv9zFSWDg1TfXwwLQcgleBA1Y
 M5t3Zre1M+vWhJaj5sHUc5ZCiSB7B7gQuReeFl2R+UFMS4RaGWitaz1L/k=
X-Received: by 2002:a05:6830:2aab:b0:71d:6314:40dd with SMTP id
 46e09a7af769-726f1c511b4mr5524882a34.14.1739480373048; 
 Thu, 13 Feb 2025 12:59:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW+tzZo1OssAwzBnw9obaiNImi+X38rMhk55i87FP+VN3KoxTpeCc5C6kJ6mTT6u4kfTO9jw==
X-Received: by 2002:a05:6830:2aab:b0:71d:6314:40dd with SMTP id
 46e09a7af769-726f1c511b4mr5524872a34.14.1739480372763; 
 Thu, 13 Feb 2025 12:59:32 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-727001fd2f5sm931710a34.30.2025.02.13.12.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 12:59:32 -0800 (PST)
Date: Thu, 13 Feb 2025 15:59:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 3/9] migration: Change migrate_fd_ to migration_
Message-ID: <Z65dMaOdtyWPGKgG@x1.local>
References: <20250213175927.19642-1-farosas@suse.de>
 <20250213175927.19642-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213175927.19642-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 13, 2025 at 02:59:21PM -0300, Fabiano Rosas wrote:
> Remove all instances of _fd_ from the migration generic code. These
> functions have grown over time and the _fd_ part is now just
> confusing.
> 
> migration_fd_error() -> migration_error() makes it a little
> vague. Since it's only used for migration_connect() failures, change
> it to migration_connect_set_error().
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


