Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360C6CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 05:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKrXZ-0003vF-8r; Thu, 07 May 2026 01:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wKrXW-0003up-K3
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wKrXV-0008F3-8P
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778132687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ksYYi0Nq4LVtSvzVGWe9n0EIKph1bFiyPlo2NLUQ1M=;
 b=dC7mtwpYS01vGHQbq1aq2rBfoZNoqtPLEJNu/O3HmwjPLYOzTl9suZYb5ku/QTJkmzJK6H
 DCqKXJ+gScwhn572tEOKUKFmTR9Hwr4x9mF0GnY7CX9TEwe1RguXMBtSwcg0s7pvdQTUNp
 c/JNRKi6yLJpRh2tDQoGGyqtAbNK6WE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-YMhm7W51PqS5jKd-_XaDzA-1; Thu,
 07 May 2026 01:44:46 -0400
X-MC-Unique: YMhm7W51PqS5jKd-_XaDzA-1
X-Mimecast-MFC-AGG-ID: YMhm7W51PqS5jKd-_XaDzA_1778132685
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C65419560AA; Thu,  7 May 2026 05:44:45 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25CC0300019F; Thu,  7 May 2026 05:44:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/4] qapi/net: Wean passt off QAPI type String to
 improve documentation
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, lvivier@redhat.com, 
 sbrivio@redhat.com, samuel.thibault@ens-lyon.org, 
 marcandre.lureau@redhat.com
In-Reply-To: <20260506105421.2461117-3-armbru@redhat.com>
References: <20260506105421.2461117-1-armbru@redhat.com>
 <20260506105421.2461117-3-armbru@redhat.com>
Date: Thu, 07 May 2026 09:44:30 +0400
Message-Id: <177813267024.2413233.14832448496963067376.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=521;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7u2RM1ewWT6SP+S2QFztAplhvO1ACpp0GZEfwYC0whc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp/CbCb33U3IxBbF8wnwQc86h3I+z7HXeodlyGA
 mJ3P+nbUpSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafwmwgAKCRDa6OEJdZac
 5WaZD/9xNqLtMa4Zx7YgIW3FfccpexBePlk5ov9U0JoM4bBzp6cG3Lm+IWtApWoLisulv1DXgWB
 vXC+VXThmHX0+4GQPeSopFnb4VPed3trxRGM+xEIgZFpjH94MKDz7uswzV9usfIOGcuMYy/z8iN
 uwsa1Tm4mzS+HDgmU6KiGxNvzLi0J2Q2HgWLd1GnM4z/zCx/fJKwv+L0qc9wkpNi/f9tmeLD8cE
 bCfm9ERW4BMfY8joyqotbkn+VbksjODoBHu7mSlkm4hJn5CU8Wd8Q28zBf9kg1QUo+GvCWtyywX
 3l0mEdZ77xyrlXE9qxt9MdVFhJrGEQ8AWF04dT0rwbRnoi06PJuY5s1FnpZCxJW2pB771AS5QIM
 XZRHV67bHDhss9TeoHnOrMcsitYuFWDKxomEQ3J/UoEjMmf7qjxYC3W+qdRf6OlVXGu4FYoYPWG
 RrIxae0UIPyrn68qPD+iBH0em+OPkzBQkyUAf1rdQ1m+rWXoS5u+echfny/jqcUCbLGC8pIUcO2
 /30tfEbtGS6Qkd/9dFmt+vOtCC0Jo5zvKRzpLVYuOM+DyDlzQbWQjsTzMxmbLJu2BNFKWFu+zEm
 C1iajzaf/wRYW/s8WQa2T6K41/xc55W3tW0HE1hOcpKaInqj91L1PfsaHklbbxVwRMqJwU30GkQ
 ZnImE98QZmVIkxg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 06 May 2026 12:54:19 +0200, Markus Armbruster <armbru@redhat.com> wrote:
> diff --git a/qapi/net.json b/qapi/net.json
> index 8ed51b665cd..45ee7ac7ffc 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -114,6 +114,41 @@
>    'data': {
>      'str': 'str' } }
>  
> +##
> +# @PasstSearch:
> +#
> +# @str: DNS domain name suffix for host name lookup, or "none".  See
> +#     passt(1) option --search.
> +#
> +# Since: 1.2

Since 10.1

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


