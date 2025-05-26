Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63186C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 16:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJaNT-0005Vh-La; Mon, 26 May 2025 12:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJaJI-0002cR-Pt
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:04:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJaJG-0004Wh-HY
 for qemu-devel@nongnu.org; Mon, 26 May 2025 12:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748275455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=FgoQaLA4Wa46oqdRFJKFngFndoh5SVMwQgVOhRecMBUKv2FOjMWzg9lycWAJYKVWaRRv2o
 oNlp3zRl7H+zUGCSvQ40Q6o06kfDLVn45LzPxsXA1umZ7rLA3uVptPOlAey4UmHfM0dcPy
 pgtXJ8N+q8OSzirt0A7Nl/a3mxYOLqk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-Dp3D9Rf5Npi7uaTubOpeNA-1; Mon, 26 May 2025 12:04:13 -0400
X-MC-Unique: Dp3D9Rf5Npi7uaTubOpeNA-1
X-Mimecast-MFC-AGG-ID: Dp3D9Rf5Npi7uaTubOpeNA_1748275453
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb61452b27so197309066b.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 09:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748275453; x=1748880253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Y/zTSrXcORT2ycrz+vB7lj9VwF2qf0kmYahueucRL39B3BcZC0oobmr8Aj5pOhC7C/
 0OrQ1mPra6sZ+pTC0wFcH4W0OD5y3wvruFN53sBlsoI42uIRQ/mKuhEpLDX6CQ5/9404
 LrmhLvBgvomJpFaUWiyg9lSIt8fvyNd7FwvBtF6WR/5NalDhWxSDq/wQudxnbJ4hihg8
 QERDS7ECztu97MM7s00YgbeZ4Ffldv3436/XA3iu6pojOtylg4CKWqCdHHSFrDFfuRIn
 JeZ/cBsuspezi2rU2s5mXr4F8DBc7PX3rWNnTT/qdc4CSHIxs91cV7wOS4MMKl6WuulE
 /U5A==
X-Gm-Message-State: AOJu0YyavztYkobSxOp6jIW8mnyPkqAg3rsWxgjUESK3AZoM+FGALNbA
 bY9TesQbdx+AjcaJTfy/WwPB1mAlXXNM19lLdN97Y9LmOWRASox28N1oxe7NYi4VgNGHVST+EhN
 UfqeQ90M6iMAOk1drv2SoH4LYEeLoRb1DChN7oZb3Fbi7eKumoiWVSDtJ
X-Gm-Gg: ASbGncv+/8/Ns78FGS+FbA79bdxEbPs8s42obH1RBXKWLCAdDTbsW+UPqn2wE7o1gF4
 RLFLHdCOfE+w0IP1IbHYNU9KIRXquXOpspH3gvRCLtChmptRiMnKnIUrs0Tv/+lpH044Pfv43+L
 JirvzYnGzuf1I1uW85G6TsRmaAK/NA49YZADtVkzy0Bk+eFf/8ScBOGHkeDdEurym5tJP/J3SHn
 6ibs9u1a5cBxVfJy8jE+2JDAsG5quGdFE6mv9ji6KGBkSFyWoFBOEWEXx4wU7fq7+P0m7hbbrTx
 lM9RGu/yrRYCyQ==
X-Received: by 2002:a17:907:1b0f:b0:aca:d4f6:440d with SMTP id
 a640c23a62f3a-ad85b0ed0bbmr883564666b.17.1748275452689; 
 Mon, 26 May 2025 09:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnU9VivD89wwSkujsAcYFNMPfNh2QhGEhr9+Q9TBYXobJiEq5O4HDF/JIn3oLM9/36pVXLVA==
X-Received: by 2002:a17:907:1b0f:b0:aca:d4f6:440d with SMTP id
 a640c23a62f3a-ad85b0ed0bbmr883557966b.17.1748275452172; 
 Mon, 26 May 2025 09:04:12 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d2779b9sm1684178966b.81.2025.05.26.09.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 09:04:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/7] single-binary: build target common libraries with
 dependencies
Date: Mon, 26 May 2025 18:04:08 +0200
Message-ID: <20250526160408.1074561-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

Queued, thanks.

Paolo


