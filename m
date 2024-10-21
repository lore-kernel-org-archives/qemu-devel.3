Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F3BD0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qpu-0001ao-AI; Mon, 21 Oct 2024 07:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2qps-0001ad-8q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:44:32 -0400
Received: from mail-sy4aus01olkn2081b.outbound.protection.outlook.com
 ([2a01:111:f403:2819::81b]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2qpq-0002Sv-Qd
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:44:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyyXdahW9ewN5bvvGWsLB0uRxJzXT57Bch3raxdoDwy8m1hF3v6k55J/CXFfPWCuaPYhePOsPOQhRs7csdzZvKUL/EmuB+W9UZdEkvVfS5zYZS2tVjerXBkRtzabih2Mjrk70ZxwGqX3c+WA46WmMturTUgiymB0Z/TLFfwmBnEbF2cRc+vGd2iXb1oQA65FX0rUq0rHu02Xcp+3vCj16vRoZsin5tKFen2e9tvk0YotlaY4B3kxEDcFZj8L8MGXZ1AQIVPwupX0TSbQ8G+3kzL007vtaG7zzSJO71NfGtHIjmsrD+xA4kE9ImxW+fE12iw3O7SbtfpamXxaSJEB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XNSWmagZCmi4hFDGlbMCBe6i/oppzYk978luUFIzu8=;
 b=LQlNGAdvlVCmz0HepiLcTkY+e/tOMwMEHE9CJpWMes5hyCQQ9dMn0rI/jgStUfPSSnwRzpoqb1dg2CnoDc0EspAkBTfqyZ1nlpeaDH3Vw8HDdwDgXrEqmIrzbigT//bN5KKARKP+5GWCkYv44pSlBwCiVuP/EDTVPWXObkG34okK4M0dT9K3UKI2TyZNHSyKURhaYxYO0A7dkQoT2HX6nvOajnkr/xIBsdMFNb+vnKvI0VHGDqsAwVCRmDedYpQPw2ItC+O6fRAeuwMXiX0bSgOm6DBK2sn0E2FF+Mw0I493I9JUgVurdnqkXX+OMFnzrz+eS7JpeE1/ebSNgxl7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XNSWmagZCmi4hFDGlbMCBe6i/oppzYk978luUFIzu8=;
 b=itFINF4e6v9nyc8RAXv+byWZgrcJmnQJsC4RAF/s3QJIQdjKX0rhHBxdtOIRgEPs+Kzhx+yrnt77iNCvUhMGVqQKYVllZC+GfbSEA8LDQoRwUS+CgoN8XRi8OsfLmIOJDhG5MxqW+CsDVOvAxYkOBFpoTwJGitl1Ue7//YuaQbPAqbslRB1bKqjlzbL7WTjWTosMKuWVHCXQgaYnSOJBVnNkHVIAqhX7RY5ySfc9FcIDbceXhsyA+4XiUDdb7DvME1AVv4ZtT003dibiEyTsaQF7F/BDWZhxkYMrt7xNxxkq2vGId+GNxgbZg5zfT7b00fUFkiKz0EcDP7rSsQlvBQ==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0171.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 11:44:24 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 11:44:24 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-12-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 11/13] rust: make properties array immutable
Date: Mon, 21 Oct 2024 19:42:51 +0800
In-reply-to: <20241018144306.954716-12-pbonzini@redhat.com>
Message-ID: <SY0P300MB1026AF4B292F07970AECCF6095432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87cyjtsmsw.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0171:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1a908a-1b4d-4cc2-976a-08dcf1c5b5d6
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|15080799006|7092599003|5072599009|8060799006|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: AtEqpjlWr+rnlRC/yY23iUBwjH+p55PCZpqYA0VL8VCVS4IR0wFHWJB2fCxhSnn9jUzqZairiH2PNru0R8hfju+nfw1hqcchYWobZ0hAUBJDOCBavsgUUw6+iTgrMRCckP0w9I76bb8i+4hLeXCwDvGzt6nNBafwRglnYKws36sfra5WvA7JBmnAesFplBXdiHCFgC6qijGBY9WVW4h3vq+P8GyLmT8f8DdcUWUqMW358yRjQPU0fzHnuTlgNDtp0M1GMr2wP9p3knNu/3uLGFqkmLq7tEaLYrtmXzNg2yNhqJeqUlJSGZJzBGbIc+gMfHmF89adY4EklOQ0OPt7MHJQx370HFyS8ydn2j4nNEpDhheF3o1bUCg0qm95kN+E1J86opyd/3r7OYt0GlG6wqp+8c4QDarDLC2dqLZwYRHkf9Yx3rkZbGYT5E8jAu0Wy2ur+wm0d3APRwuig78Ta1LmZGebo2KMTnZ0IQzGAQyKXcqZ8Z/EW29Y2RC9NT3Su1VcIH7yE05lsN7FXh2P1LxeQyKt5S32mj+lvD5jjssY0x0clCefznFleknYDqtHfuU6RGqGCDkPjR0YHuVZH/M29tw18WtCf6a6f/LkwIiwZ0Fc6QL5g6CTcVUM2yEZQQqK6B2EAVLLxpavFU1SF3H0/MSLQqJY67TXYPzjk70QYTkFW7qSdT18iUnsrsD3a8uGpo5Hk3W/DiN5J6RE0otgA5LgdNA8RbideIH3IlE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SrQJWwERu0TqPal+kH1LuxEqFBpqDfekGDluEni3crkK0DKg8X4BG9SVYAhK?=
 =?us-ascii?Q?c30ZuHWLsSaAnpHkJoMcfhnjijZqtK4arTy9407ykvzJBcH/RSnBWAOgaF6f?=
 =?us-ascii?Q?E+9pXhe1QQF1yofOUh1FCi/LvSgVv7Su9QSuTf+JgLvSZbZJRi+RV7yPbipc?=
 =?us-ascii?Q?dChEnCzsmjAdCwcqavoIkBmlFvfyB4xDgNCRicJ76a4rlCdjH0FdYA5zV9n8?=
 =?us-ascii?Q?dAeJflt8x/RWj1cN9p0f21AM8zEUzp03yfRu4S/Fwjr8YSdbY7yRqG85vhOE?=
 =?us-ascii?Q?RzrNaIHXE5kjh8kPd6YwZz5zFMpdOEysR2DYuMvzB+aqL0ULXHpYRdDfoOVW?=
 =?us-ascii?Q?Tb/3CsvbpJbIfBi/A80Hp5wWxEwYItHlnJIcPxQD3/lEX3bpD138U8/mupso?=
 =?us-ascii?Q?7H0tHJdmmoFkEGnQ4FzbsVlNOLDk9hk92FbERMrJI9mV0zeob8uhZGFIU6VL?=
 =?us-ascii?Q?ooBnlEJvFbcWBZzxeViCGjksEWRtenOlz6RgG2AbIVuvguMl8otBXYsPaZis?=
 =?us-ascii?Q?z0/DSNz1949K7Fi7KumoRJ2ojGqSVf9Y0ehO+xv+N+18EwpSNaAR6+cpb6+o?=
 =?us-ascii?Q?3QlvcZ30WWOkoeUQubY/GzV2FKWTUsduZgfbwD5i9BAGTLnkbp2lQsZUr/1X?=
 =?us-ascii?Q?Pn9xSEkPYgct9vIahSOuphPpplN7t0DGkoJ4E/6DQY7+jm8BBiaAapf7W1Kk?=
 =?us-ascii?Q?o6JZxvewORNyCl5fjJYGXMoE71YPs5jMCQ5hjVhHqCbW4t4aFoMKU4LE1plB?=
 =?us-ascii?Q?wks71BMqtVlYvPbkIWcuL72Hn63QwtC48qtsfeX2wddsMb7lhFcZlSsqha46?=
 =?us-ascii?Q?zoKoJSJ7X3wKCKqcGdTH3J0vElQyCtrU1USg5AMztKHMp+i0O42pg2boO08/?=
 =?us-ascii?Q?zcO8RXbWjP/UmhJBs4SelWoO9dOARrTVioTqeUIQcvelQZtyMNp5d5SiNqwL?=
 =?us-ascii?Q?QGIczTZhR/uDY0snqs/gre09S/iDHmbphNG6wfVRlUDo+yHbivvnn+480sTq?=
 =?us-ascii?Q?spqSGNO/J/nuFq67Zro11cQPuY8rfKhJYvUhMFG6mTRmHPnXY0amboW2kVpt?=
 =?us-ascii?Q?RABQM679pL5aPafLnLS4wW+2W1WVhzQaCS+9H30UYNr1aym26v0JIb7CJRRL?=
 =?us-ascii?Q?2hPAbrtwCijTW1Tt4SaFskaqsmGn4ZV/K0b73EGR07zkYdZYVSmuRkj9Z83Z?=
 =?us-ascii?Q?YiJLSgjzn6dlPSGqBDp9Wg12SQm4WckJnn+8kPrIa85me/9x/Lk/pGL35f8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1a908a-1b4d-4cc2-976a-08dcf1c5b5d6
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 11:44:24.2640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0171
Received-SPF: pass client-ip=2a01:111:f403:2819::81b;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> Now that device_class_set_props() takes a const pointer, the only part of
> "define_property!" that needs to be non-const is the call to try_into().
> This in turn will only break if offset_of returns a value with the most
> significant bit set (i.e. a struct size that is >=2^31 or >= 2^63,
> respectively on 32- and 64-bit system), which is impossible.
>
> Just use a cast and clean everything up to remove the run-time
> initialization.  This also removes a use of OnceLock, which was only
> stabilized in 1.70.0.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>

--
Best Regards
Junjie Mao

