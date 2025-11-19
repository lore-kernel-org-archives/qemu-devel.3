Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D680BCF58C4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 18:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLmYS-0008QS-P4; Wed, 19 Nov 2025 13:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLmYL-0008OO-DM
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLmYI-0002YC-M6
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763575507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sLup+W7pa6WZ/k6QZNaZVOA124clRvPAt6nyoZoANYk=;
 b=O4Lxjj8FbVBqJT7CeLGsHM7udEY7HQj7VIKzCTOX4HvhP8b3jUzHKToljoKO5vSEkEJzA0
 JMJo8R8M3wXKmXoKEbfRlxY9Eo7k/h37Bk/RvOjdhmeRmDFKD24SPFGOT3YDYDNVPoLk0P
 EPCiMzbRFBKlbGch/aLqRTddlxo9bSw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-sCFOClP2Mcytx99_Xg8q5Q-1; Wed, 19 Nov 2025 13:05:06 -0500
X-MC-Unique: sCFOClP2Mcytx99_Xg8q5Q-1
X-Mimecast-MFC-AGG-ID: sCFOClP2Mcytx99_Xg8q5Q_1763575505
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8805c2acd64so308996d6.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 10:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763575505; x=1764180305; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sLup+W7pa6WZ/k6QZNaZVOA124clRvPAt6nyoZoANYk=;
 b=j2ZXBmpVxqMvm2KqlcOlVi0Su4InO4lAJK+GrHEDuvDoXXbawhA2zlA92TBbUu3z2Q
 DlDJTwqSuoSxr0TWNCF0XbMj4FfV0rARTVnmVeRSWXxS9VMDT+xx8VGyCQMViGXrkYln
 RYS1jYN6XcxXJZ+eaVZ/lLZCVWdhsWQCtOR7L7z53u/wtLd6EJoHBtvS+7s56IXaovJw
 ObuYWdH38OXiNIgz45wDrw2NfA305/p6qqUpyKH2weVktJDJcK68TRcSBynHKEH9e/al
 DK/WTnUgQIAfYpSEK7MX0o3VuGaDI8Ug6CR3q2EKX/SK2yVUOUilttMcY4iyuafhthnw
 EY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763575505; x=1764180305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLup+W7pa6WZ/k6QZNaZVOA124clRvPAt6nyoZoANYk=;
 b=H6Y1eomIQn/hHWsZ+ADNHqf57VNI+FLpOQfONFXhn4Ed9bfQ+wwwF9GDidFh9p2G0L
 u/phKXesSxWk7xq0Dvh934o1kMECYkLbO0rMM/XWrFBpE1nftT5LOYK/wyl2ncBXyqlr
 3U3ce3pNHY2nSV0TPJR/qvVb9P4Bn0VL+g0yF/RBCCNj5/s2crVaqjtDOP/xvcFTLs+o
 C/3ocr/Gq4OX/4v31IGqENHawJ5qFIZtXQw+btJ5kopgY05rnfQ99cI1FK2Cv7n96UKM
 NlB/VuxELw7VkMG9sTqsOJJJYyRQzKK+YkErOuu/EN5n0aNt3CfIjWjPvojsTt/p/51j
 nOkg==
X-Gm-Message-State: AOJu0Yyj4PpPhx8KhA6WXSMyB/G6aKF22U05xY9PtC4L5olWlr/y5hm4
 Nst/i2cHN3LdNMUc9itzhxrhaJoe05W2B9yC/5ggZsUgEqZbS+FBrOFlS+7LHpbIzv98/lWBwOP
 41B7nwWb5naC4ODLt1RNz4xHOuzzp+xjBNNF77P/jmGWMRz/UUDzTyCCn
X-Gm-Gg: ASbGnct0Gx05HDrAsjJ8uIPp+NAw5250slH9lea8PqONI1EQ3v8VrTcnuXF9VrmcM+p
 8UAhINGW4Eg4n7bqkssVljmiBIojN3uaGgsMylfKEjM+5bWmlL4N4A2kSOEfADDUlj7HB1x5btz
 FWaraIWMiVM2iozrVSsoRDsPcFq+X3IXar+tTWfZpHZQnfu+zIzp66EuMNvpNFLR9XvCxr55qUx
 a9evHOJS0DcdwzhHtYx/OrJFYxWnNOrHl09QcsZMfvGNbkZE8G+ZitQnj8MkEbuX648m/qpI6sG
 aVO3YxXWe9xqJS0fEUROwRPxYH+9qAhqbbtexjPILmrXixxdWu/w+/ny2MYdllCcbDcoLWaAlY4
 YUpQ=
X-Received: by 2002:a05:622a:1915:b0:4ed:8fa:6fc4 with SMTP id
 d75a77b69052e-4ee4971d531mr1625101cf.78.1763575505163; 
 Wed, 19 Nov 2025 10:05:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyg2JyzSrFhB2LMApC4ECHgD7juQRduC9UIz0/PCIU7u2oBKhMX1CSoSw3khRb1Qff2CShKQ==
X-Received: by 2002:a05:622a:1915:b0:4ed:8fa:6fc4 with SMTP id
 d75a77b69052e-4ee4971d531mr1616981cf.78.1763575499123; 
 Wed, 19 Nov 2025 10:04:59 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88286595ea2sm138610226d6.51.2025.11.19.10.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 10:04:58 -0800 (PST)
Date: Wed, 19 Nov 2025 13:04:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, farosas@suse.de, eblake@redhat.com,
 vsementsov@yandex-team.ru, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH 4/5] error: error_free(NULL) is safe, drop unnecessary
 conditionals
Message-ID: <aR4GyA3nfvelqr7i@x1.local>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119130855.105479-5-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 19, 2025 at 02:08:54PM +0100, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


