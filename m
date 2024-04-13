Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8D9C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 09:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rva2v-0004fj-Aa; Sat, 13 Apr 2024 05:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rva2t-0004eA-8P; Sat, 13 Apr 2024 05:51:39 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1rva2r-0003cj-S7; Sat, 13 Apr 2024 05:51:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso16284335ad.2; 
 Sat, 13 Apr 2024 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713001894; x=1713606694; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wfCSZiW9m2sPQXA3lr1sCNEaD79HpO4qmE698hitf2I=;
 b=XPldLAoA3NqZfuj+d7YXkTZeUjxvLODh1BdL+illy9ICvLV6MGbedZnCWEfYIezXJA
 8WOacLHhpjL2YqJVo1Ow43FVjpkIlM1B6wX71OzaHHTUFSB3I0gp8h+Bl/bynJZYKUHN
 /y/Y/XHrhWYOpAzN09WwExSb4sWgrZW4v9dbM3phzdAQUA9vYviQcNOy7d67DXWNXnRZ
 wqzRQ6dUz1IVUK/IagnUr4dXLXM3mgKPYrvobcJ3AW3CFawjoqu/I3PgG7DAkl81w7w1
 DgeQYBfMQlWtlfjDl8jCDYt4PoV2jDbdqU25LtnAKhpILI9rt6DvebuYci/qVa7/3nZJ
 HOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713001894; x=1713606694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfCSZiW9m2sPQXA3lr1sCNEaD79HpO4qmE698hitf2I=;
 b=sGVIXqlMfllX76ddJ2UNJfOrp5oFwt8ZkHVWOfjx7cnBoH/b2+O8ctdSw+xIcYWmau
 3mosFOpTtnCyauSjlIT8N+x660dOI3zOJmgftQNXJz6Y3PQmg+TanX2Sydf9tLUzIPDw
 L5HQJUzy1A7JZEdxNdsyvK2abmJzpn7EEvRrhDnWUdP4PGdB2bZ6YWXTwiFfHXouMI3B
 PaI1mZtbAV3ydlT8bMYNQAT5KDze0cUWSA6GqvrlmtOv9Wjtp4bUiBm86VyaTJMWkmvq
 YU+Ypj7TZ+lF9hzlTcVf22HAXLjH4rsLUpqTKPm/oNPgHwYj4A9tfJboNMtuIVrvjE3a
 JMzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ4yzsphjpYgz1Fz+rJdx3kd5kGyQXpt9zAzd71/a1+XM5B3d9VYOzzZT0+xiZht4GRhwBqCc3PH9nEF4DFWS9iPgdSxo=
X-Gm-Message-State: AOJu0YySIOodjCJJjsx/ylf20qoagGIdJaZLISyitepenug5pDJWqrCd
 OXo3Pf8CTL0ePtoqO4Ekm883SzykZ46qfGnmYXVkDSPm/viNOOOfFnN+BB4DM/9cRQ==
X-Google-Smtp-Source: AGHT+IECATYlUdoXQ15UBKFBWF03N0eaI8yMDWoXusp8yjuUT50MMi+daUlofMz5j67l5sFmA9n4pg==
X-Received: by 2002:a17:902:a515:b0:1e3:dbb4:2c90 with SMTP id
 s21-20020a170902a51500b001e3dbb42c90mr4931748plq.64.1713001894537; 
 Sat, 13 Apr 2024 02:51:34 -0700 (PDT)
Received: from amjad-pc ([192.228.218.97]) by smtp.gmail.com with ESMTPSA id
 l16-20020a170902f69000b001e29c4b7bd2sm4280764plg.240.2024.04.13.02.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Apr 2024 02:51:33 -0700 (PDT)
Date: Sat, 13 Apr 2024 17:51:29 +0800
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH 0/3] vvfat: Fix bugs in writing and reading files -- PING
Message-ID: <ZhpVofMHYUewg2qq@amjad-pc>
References: <20240327201231.31046-1-amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327201231.31046-1-amjadsharafi10@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping to the vvfat maintainers.


