Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D74CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNYL-0005EO-V2; Sat, 30 Aug 2025 11:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1us2k3-0000VF-FX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 13:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1us2k1-00011z-SB
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 13:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756487900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PFl0pE59Dm5tIbM7MKcjvJkWCie7MVPDQ9LZAzsxkUo=;
 b=WuMypc5eiI7jhiepsC0QEU1nHyto0/H2WvuXGH8hFkyQ2Jlwj/GGNH9QmBLkE00Ua7nYpN
 qisrS/0+IpL8TDqp0aME5c6Ih+AW7DG5GiAAuiJheydV0hbBbd46yekhxwrGM2t5FtqDds
 ySj/3sL7OvlgYftw5crhu/i6hZBeTlU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-9X2CJes7MketVDgEnBeUTA-1; Fri, 29 Aug 2025 13:18:18 -0400
X-MC-Unique: 9X2CJes7MketVDgEnBeUTA-1
X-Mimecast-MFC-AGG-ID: 9X2CJes7MketVDgEnBeUTA_1756487898
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7fa717ff667so375033785a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 10:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756487898; x=1757092698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFl0pE59Dm5tIbM7MKcjvJkWCie7MVPDQ9LZAzsxkUo=;
 b=Jo3S9y5yVc9bl3pYzrdP9ZtqyHDGrHmeeLE7JZr/KGtAFdk/smIRLK5/Xq0pLx/l/W
 lkv/Wv7b0jwjKPzi93A1/2DEB+IfI1YfWBdhP46aKAWjKEynBe9PUryhRAi28bzNt560
 zuEaiR/MLTuTUetZUvn2heDhV4QOWu5Xt/sst207WPnoAcFFtwb9oU2SBSiu8n0R72T+
 hPkE5YsBcqan0t7+QilYRORg+BQGD7cBTYt9HkAPv+hB7PYNkyPxmY1E4AP7XZ2Hdr2z
 4k5EWCdDX6+JNP1y+VNKHroJB/7CmHe8/F8+ySj8/51IbYqkGBM78nat+4SN341fgi4y
 4rxQ==
X-Gm-Message-State: AOJu0YwO9akqtsReWw152csX8Z/SSsTIWXjn6//lpJfrwHd8eVUEcYBJ
 taB3MHz24kwoc9wrGYQWGMZq5IYF+rUiRNKEUxn1MLJJ5/JTqSIvyombCVJlXRu5EQZY1RB9Q1L
 u1Z9w4IUCI+GESAXp68rmvXuaIDNp/gO3Jvm1UPVKPLgcGACuLqgahGMH
X-Gm-Gg: ASbGncvSi4OARkR7Ul2R5TwUPtDe4OHxrLaGr8E+gnpYJ6WEAuzPqBcPEXfDJA6iLbQ
 delrF+NVMgNbVgOW6DSHuyVr7slDl8ZLSEo2CECKsvOnFDTTFdKQKP2x+uT0hzhSKwWEmri9ess
 SO5VAcAZSutcANYss4rlA8Eqyk4eCrLuwco/EZSjIRTHj/HzMIcP9EkWr7CVvwzC6QOLVh401eK
 VSAA4pHXQ4s3sXEvYph+CECr3PgfcQEx4AlS8pwUd4Tpdgepz1C4azRZd9XfvB9+N4YckabXBkq
 iuSzZieeLiURUiQEqMSLpyBPw9zHjGl3
X-Received: by 2002:a05:620a:d82:b0:7e7:fff0:70cd with SMTP id
 af79cd13be357-7ea11095d10mr2833402485a.41.1756487898190; 
 Fri, 29 Aug 2025 10:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcMfAWIc9lEuEoM0HvqEmSdFa3eNz6SZ2ayR7aKShN3KQqFqF9Q6rzOwyXlHeqYHpLOW3WlA==
X-Received: by 2002:a05:620a:d82:b0:7e7:fff0:70cd with SMTP id
 af79cd13be357-7ea11095d10mr2833397585a.41.1756487897573; 
 Fri, 29 Aug 2025 10:18:17 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc0e31be10sm220266185a.16.2025.08.29.10.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 10:18:16 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:18:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 0/9] migration: Threadify loadvm process
Message-ID: <aLHgzcDypW1r4Sbm@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <d801092f-76da-4b2c-ad35-c0c625c78861@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d801092f-76da-4b2c-ad35-c0c625c78861@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Aug 29, 2025 at 11:29:37AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 27.08.25 23:59, Peter Xu wrote:
> > split the patches into smaller ones if possible
> 
> Support for bql_held parameter for some functions may also be
> moved to separate preparation patches, which will simplify the
> main patch.

Sure, I can do that.

-- 
Peter Xu


