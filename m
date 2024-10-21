Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE45AD0E6DD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pVl-0007sY-KP; Mon, 21 Oct 2024 06:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pVk-0007sP-As
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:19:40 -0400
Received: from mail-me3aus01olkn20827.outbound.protection.outlook.com
 ([2a01:111:f403:2818::827]
 helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t2pVi-00005t-Ow
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:19:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMeF4OJKgL4QLYosxVwIJ4W4EZUkFPjXFdnEIYmuaNGokor/oSFsR3sZ+K2YgB1Dgd2Rdd/DEi3X7s7WswtZAAzZSFmwj6mpfBTnVGvjIfE+bL3IM9lTQI5mcxY2CHQ0lOY4UJmFkpJQ/SsdcfApxOQ9jwmo6kr1OZ1q36Nopdj15pYcoYBDYVPScSmQiJRSDMppKO11dV2N/+3oC4+j+/xJTr+AwGseCw8IhZeg+b9KAO8bWrWjxG5OY9xcj0J+n2uAlXmQ1cUFTlLaGoYyYRYE2U9i6mvYlZI4uy5XIgYSRsmBdPvPfRE91uHJdIYosLTTsEBiFi+okg3vSIDGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4pkI7ylnULeIW42FKh0Dr/W+S8fKIF06U+q4FaNREM=;
 b=eqnmTHPm5m5cdWMnwfseZQiIteE98dkY/kVRqu8CTYH6Fk0SFm0EG4m19G54eae+vnMy67gSmhk607XnHoDDR7fqhbZuQ6Z9QXTa1PGYe9m6GnqA4qt6iL3EYogC0JT8GRCeZAGsOjbhBkzAsi1JVgaJ8qq9hpNR2lFv9xMr0sWl18sxBtLQ4zZS3aJFUgv72X24WWxh1Vg+mBhdDl/wJd1V7R3NDWE2LaVd/MJu9hXu+3m4DQnjpHUCBT4KpL5ZYKBmJBamgc9VVGCvSNx07XXP3FC3I0kjNIiSpY8PEkWvUd7g3WJ4MRvOkWiagbEyLDcXt5jvU+MF8dCI5YL8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4pkI7ylnULeIW42FKh0Dr/W+S8fKIF06U+q4FaNREM=;
 b=Fw8FyzfHnjoDZJxP3kAY13O7Dmcz2Uhd+rzWpnS11ZIT7+Gmi32VSslLuWBj5+A9T/eRa4aVLane6OGr5MnoWHLSWEnPJyyqEiZ6949Z8mOxWUSLLIXbYA//niynA3hDj/VYU/q1P1eT/LlHwdfAoCit6XvOJCCbPOpVWqZ3QcIFckK5F6DhEBCaGBzS2fGDVJ84W6YiX0RYlVTecXewJiRXu2q7FLFBaj+zVGyNgY+rCV7IqMG3nF0QhqpsfTky8gmwx6fOv1HrSo8Tii25ONfRvSkP9+ncG6PYv3FUtxW5mPVnCGcnIS4dBizOWN+K5m6ByYaUUWvMeCc3qOZkNA==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY3PPF9305F0E3A.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::49f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Mon, 21 Oct
 2024 10:19:32 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:19:32 +0000
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-7-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 06/13] rust: remove unused macro module_init!
Date: Mon, 21 Oct 2024 18:16:00 +0800
In-reply-to: <20241018144306.954716-7-pbonzini@redhat.com>
Message-ID: <SY0P300MB10265F36FDD39FD0B258F37795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <8734kpu5b6.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY3PPF9305F0E3A:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cbd670-085f-4e6f-88e5-08dcf1b9da92
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|461199028|15080799006|5072599009|19110799003|7092599003|10035399004|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info: n2mVkYrGcHEw7X7TfIKS6RW3dwRJMPtBjqsy43obneuW+ZjEjocqldV+1fKY8x1+l7L4mi8BEZw4ERVdDt1OhvFIApeUnBnTEuzmd15nP40QLpaE3rBGSFAd3uuPqSeBZoLk9ZQTWf0i1it4uIEP4qoFCRfTD4yTjUK2FFDmRSDnFPf2oPoDcOlXF9pP7sy85HEeGSSe+cj03zcEvsgyhf5dRczPn65fCjoCKu1L9NSBFUVldtYVw1f9ysx7F1023RTdxNJQS0iUBhgL25w6SwkOjSYGYnXd2vUP8lnPv+FxjU2gL37dAhUpQ1mDsS9mnb+OG4XwZodLCzpR4sT/ZB1et2Ax9Hmi21ZxpBnBP9LGidcyJM0kBDigZhA7igkKqSNsvHQrStfojpanUK1a1fFk9qkFbcFTwgmI1ldVcOVM0LRS0pxHIuwdm/URgFiIY7OIhWBYQrWWpcdsGix5OdhrLVFDrGdxrgZdNQxOBHM6qQF7+QARO860X8GpbZFL9zXb1Ax6vhi284e7F+M9UipGZ8GRm2CcVmtaIKOM/JHZH8VhDVuOhI7xxd9Au4+5GXkUFPFXSK+OulPZShYcDKtI0BpmvhKPyY44QytBCIAwbONvWPreDdtNLx4yJNMt2dk/82KWJ9OMGxOh6EOqe36Obj3gSLLntIlCqxwi/6dPA4snYY0d0lOHv5Uqq7N4F3eYCRtEOkxgU4p0LEPX7mQcteI0/8SlqlliQ/+gfyN8P3e4rFeAhGTF0R1nmiR7sknj9aDN5GWScTnWgCWsgkIU0Dh1LLAkd539PdpZ2t7PcgGhd5D3xB8p3ujPzYfu1YiD0igQXve7DpcvA4iPZCNcytooFvrxAWFMqgFwHuZI1ibQo6CchKuq8gnhIOJ2/fRsKFwhcyffNVzvzI24sW9MNKhwpI5qs0A3Coa0YMw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cMfiLEPCY5x9GoJT4P62rPvAWw1RFCTxDBmFxAfBAf5MB3HDUXtOf2muW7D8?=
 =?us-ascii?Q?I/drbPplWO9WZrYeWKK0Gj+aMNzQ/1nRPGMRo8nZXfmproqmwIzWflxwt6Rc?=
 =?us-ascii?Q?f9Lzuc2nKI95t0ryV6dstPGbMUEQD2wKkO0qCm277foOjtnN8vAwGsKcx1jA?=
 =?us-ascii?Q?TsOG4iSbR0a6b+Ywlj9nY/wVr+CSORmbYHwe6yLOn0GRcP/IZDJlm9Xwxh2j?=
 =?us-ascii?Q?SiMj6lECslsmkJBC4r3z7NlCTk7bmi7GCCxNkM3E2Sj2n7o8leGLN3nh4OZq?=
 =?us-ascii?Q?cZsq4IaRYfSUJZC91HzKrEzPAqyXNcxAv1p5kLoZCnFqhmsGUgxJLvK2ZU8s?=
 =?us-ascii?Q?B0wLcGCbJRLbGfjCxOU4GkORat1v37i2fHg9gJnwGIHU2EKQUgSkEO+OOyXI?=
 =?us-ascii?Q?Lsj118wefGzOIHK8kRGcPdHTrr8mjpIvRbeMRvNQ70FBHLgboQR1jsyiOsj3?=
 =?us-ascii?Q?787pcd+0e/95ltf47j/ng1i3RH97FbuNNmujdUqrWQEifqIv+X9dyBiKEwEO?=
 =?us-ascii?Q?5NgDieoHKVsEmdh2fR3IA6InqgWJXxINmDbpCXQtTnllVX5B3plDN1JRzkDY?=
 =?us-ascii?Q?IhgR5sEV658k45s0fuaeB19Q9Z5jkwLNdHkTEEPa3rlyOp28YmyBGSrA3CxO?=
 =?us-ascii?Q?+2UFPkTyi2hrd69SSo2BTGoUBcb/B4QRb5aTtHhd91XQW9exqj0B89TCymYe?=
 =?us-ascii?Q?3c9ml0h5bzX3JuvGK+SCwovDsg8oDSnhk1O4JLTBqgosVNVXW/mZ0O6mLjhQ?=
 =?us-ascii?Q?QofQ6wXqeKnaSwLl3jg9AV5boLz+8xva9sDDXSVSKYd8THOyzJZWd8U1R/Zu?=
 =?us-ascii?Q?2Y5F7aBuUScfBRrmT/Urfrtd2l5n1l8b04ArsoRzERopIqOaKKDhvSpvPXWe?=
 =?us-ascii?Q?wmoJ99UtYdWZYcPySl4LLW8gpqDowfoEH/6bfKmPaWBW3Y1gmo/Qsv7VU/ig?=
 =?us-ascii?Q?tlJb0mCDpchQbMt4Mm5UUeUKVsS1C3IBYCNUY+HZnUkyT8X1zwoJyjYuU3XU?=
 =?us-ascii?Q?6GJXHsJ4RpK9NmzyeUNZTCDeCY/Hp/MlPpGLoE7hTW1QEXk8WMEbTQPNdoyb?=
 =?us-ascii?Q?jjCwa+aTcL6vkvDE/OwOcgPN/jaVa0IY1jh1H8CgzQvZyZcD4RORDsMybiG8?=
 =?us-ascii?Q?Hdr3zAJA4MXYe39dntQCcTH0kEtgCJ2uqgNnouZihFNTmwX9+GLRKaMLPu5N?=
 =?us-ascii?Q?ADFfMQRuRm7c9irBeUnvlohxK1Iyz/K7UOV6ttvX188fDe3PblE5F3BB88w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cbd670-085f-4e6f-88e5-08dcf1b9da92
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:19:32.0900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF9305F0E3A
Received-SPF: pass client-ip=2a01:111:f403:2818::827;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
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

> Registering the object is now done by the #[derive(Object)] macro.

The module_init! macro is still necessary when a device needs more logic
(in addition to a single type registration) in module init. That is not
rare among the devices in C we have today.

Manos and I had a conversation on this. He mentioned that he had a
second Rust device that needs this macro [1].

[1] https://lore.kernel.org/qemu-devel/itblf.by425lac4ow@linaro.org/

--
Best Regards
Junjie Mao

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/definitions.rs | 43 --------------------------------
>  1 file changed, 43 deletions(-)

