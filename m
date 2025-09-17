Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22722CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uys1Y-0003Gu-4A; Wed, 17 Sep 2025 09:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uys18-0002yv-8h
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:16:25 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uys13-0000Rc-2N
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:16:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRfPH4Zs1z6GDKq;
 Wed, 17 Sep 2025 21:14:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 92A0D1400D4;
 Wed, 17 Sep 2025 21:16:00 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 15:16:00 +0200
Date: Wed, 17 Sep 2025 14:15:58 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 <marcandre.lureau@redhat.com>, <berrange@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 03/12] hw/cxl: Convert cxl_fmws_link() to Error
Message-ID: <20250917141558.00007ae1@huawei.com>
In-Reply-To: <20250917115207.1730186-4-armbru@redhat.com>
References: <20250917115207.1730186-1-armbru@redhat.com>
 <20250917115207.1730186-4-armbru@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 17 Sep 2025 13:51:58 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
>=20
> cxl_fmws_link_targets() violates this principle: it calls
> error_setg(&error_fatal, ...) via cxl_fmws_link().  Goes back to
> commit 584f722eb3ab (hw/cxl: Make the CXL fixed memory windows
> devices.)  Currently harmless, because cxl_fmws_link_targets()'s
> callers always pass &error_fatal.  Clean this up by converting
> cxl_fmws_link() to Error.
>=20
> Also change its return value on error from 1 to -1 to conform to the
> rules laid in qapi/error.h.  It's call chain cxl_fmws_link_targets()
> via object_child_foreach_recursive() is fine with that.
>=20
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
LGTM with the updated commit message.  Thanks!

Jonathan

