Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7422AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 09:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryqKl-00079P-Tx; Mon, 22 Apr 2024 05:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1ryqKh-000790-JW
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:51:31 -0400
Received: from mail-sgaapc01on2139.outbound.protection.outlook.com
 ([40.107.215.139] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1ryqKc-0005fC-Ph
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 05:51:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbpQ2722kgwglEkzRRT9MS8r8PQO+p94Nx7XVUz6ujuSPfiQZwDuLHB9H8WuhRmWVvJ7cjEqMICj5yq2ydhKRUm+4xBloUfOQx9YJhFCamG67E0MFLPpFga/OFRLGGxYC3VihUywhlCBMiA550cSDzp/mLypy2xUhd3If+1mMbWsMz3ORyHqucQj9L15a3f2J8bnGfTKxc/4bOHo10mumRiHv2k+Alu3UZlGmHxQ6tgS6axAgIbelHMqbg+B5BJSwFcqvSZnUHJ0FimDXvppwVSKNIpdr0lSWFJqcX55Y/YCGs3OMq1vRgMRFWv12NnKucScYbWGOCzK9+oiVCsmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBNejzz7gGrxsJ4flCRmClVMKgsk7SbR9kq3CLnh+Kw=;
 b=ZPiz5LVqmCebHSDJm6zAAEhavM8P2NAJlfznolK3DJpCzrD2hn3FSVLboYmQpftEw8aYYil3+xhSo8Ldb1TpFP/RXQsxNETRIjN2JXDR8HGHE92VlX2mIcqW2iJYSQVJKtBWjiOmQ6vk1lMoU8/YLyIl45sdPglfdNgUJcSdr3VuPwDH/gAv9K88r5p4loZIi7hHeFfJcnwZIdpFDflFhD4yVe4K709XhsB5UVgc+gadKnrsRnTW69cJNQgYAUiKMvEQyUgUPI26Q98dv1ze1YFsr6Gt96hJuTVJOB7ZDad2RFQbNUqLhS8caCgrpWCteGmoZoWu0rTzTMtyJc532A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBNejzz7gGrxsJ4flCRmClVMKgsk7SbR9kq3CLnh+Kw=;
 b=aiqinthawR56AV8R15jLmD3/JFeGu2PXXZsvE1GfO+D8KpaP+D/8rgvDsCAhObN8k8ClrO6iU6f2y0/3yyY97ec7CpaIAhl893GB6f8RW+9D74MSq70fpxAdM82bhe+jSqVw1O/dEQXNsGERp0GT0UY/s8IL0e7SooN1t9A3JOndfWm3DTji9okJnpwEctkHbTO6PDib7Gstuj1aQct5KLejz31/5bxa42Ue2uSXFhkL39F/CvPgHRd4ANjKdIgk7skQJ/WimI21gaGLP3LbJkHoUDrLz38r+fh7hfZ8btTiHlReI6Sx+Ni2Qp/RMlqe66irk6jWsZ1csKzqHNMz+w==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by TY0PR06MB5545.apcprd06.prod.outlook.com (2603:1096:400:32a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:46:12 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:46:12 +0000
From: Gavin Liu <gavin.liu@jaguarmicro.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] vhost-user-test: no set non-blocking for cal fd less than
 0.
Thread-Topic: [PATCH] vhost-user-test: no set non-blocking for cal fd less
 than 0.
Thread-Index: AdqUk1oH6TSgPS/NTUaKTTieqo5z7g==
Date: Mon, 22 Apr 2024 09:46:11 +0000
Message-ID: <SEYPR06MB6756CBA69FECC6CEA6212BAEEC122@SEYPR06MB6756.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6756:EE_|TY0PR06MB5545:EE_
x-ms-office365-filtering-correlation-id: de5cff0a-d8ae-4f2d-6a79-08dc62b10b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?MllrN2F0YmpkbWNhNk5PWWdCRTNSckFLL092TWFKczArbFh4SFJEdXJ6Wm9W?=
 =?utf-8?B?NUptVEZqdldodUp2VGZNbTV2aDhxcWNYOGlwODh2c0o4Q1RDcDkrVEFBaHNx?=
 =?utf-8?B?OXVaTTRHdk8wL2xHK2Q5RTlad25OWitzTVBySGVpZDd2dlJsS09PNTR1TnBa?=
 =?utf-8?B?VG1UQmUxWkFoVFpSMlNEYXpia254M29RK3JjT1RBOW0rTFVMUytRTk44cWg1?=
 =?utf-8?B?ZVp0Sk0zWDhRbHB6djlMMDR5dFNhTjZpUXZLL1B6bkRqQVBRd2gvc3NYdVJ0?=
 =?utf-8?B?cEtPd3hzcmFBNUUrdmZGbnRRQ3Y2V1dNUEZxQ09Zd2NwcDB3aUtnbnRxOEJp?=
 =?utf-8?B?eXpFQ1B5QUhoaXNpTzhUU0EyYW4zbmJrYWd6TlJrSTY1b1JJQUFGOFFsZERH?=
 =?utf-8?B?ZExhdVZFUnZMRFRwSkxEUSttK3ZTRndoVXdFYURzRG1mVHkvbFM0OXRUNjdH?=
 =?utf-8?B?aUxndXZ0VTdDT2hKSFhSTXkwamtoZmVWNGs3NHNLQ1Q3bWZPNVF6bG42eEl4?=
 =?utf-8?B?NDdOV2hNeWlWd3IrSm1hSndGTFpSWjFQTHp3NG93bG1MK3d4WS9BRVkrUWJo?=
 =?utf-8?B?QlpFRk9saUU0dDdDOVlITGQ2MitsM0xQd0wyUlZoTVZ4VnlxbFVsRUthSkdK?=
 =?utf-8?B?SWpCbmJYN3dNaWlxVUQ2RkdYSHRQOHBpUldRSHhXN3RGVjZ2S2JyUXpUcFpM?=
 =?utf-8?B?MExnYVZVamdtem5aRlhnV1U3RW1qWmRXVERoUTk0aEVJRGgydThZS2dST29E?=
 =?utf-8?B?NlJ5bWc0SHJ5QzZGVnF1YndtZk1EWmJ1bFBiU2NNbi9QTXJkWFlscGFCWGV6?=
 =?utf-8?B?d2oxWTJMcWc0TGFTMlg3SXlDNlJLOGh3VnEvODZ2L0dIR2pFakF4cVhtS2Y5?=
 =?utf-8?B?NzFqZEZEak1Sc0NndVprRkw3UVQ2cmhjdkZxY0EyNkswV1JFN01FZzlNQmpt?=
 =?utf-8?B?ME9LUFc5Nmd1MlZlc2hGSFBNYmRST1JQQStuRWROWlBHZDBzZE5CSHEvVzJ4?=
 =?utf-8?B?L09NdTkxQ3BCUzV4ajVETTdYYW85RnorRHZOeHJyZlZGUXU5QVM2TmY4VDAv?=
 =?utf-8?B?MFVPYUNxZTJYVm9qWUpMdTVEVUZHckt6NHVPdVpoTGY5VXlwSFRuRlJXbE9C?=
 =?utf-8?B?WnlBdS9RRi9BamhXMzFDWndESzJPditUa250c3Q2VGVqZVBUOWxkektudEhh?=
 =?utf-8?B?Z2J0Q2FXand6Q1JZNTBHRGZsUXBVUDZpUjFKNVFmaWQ1R2lGNVA2UFJQTEps?=
 =?utf-8?B?UEU3ME1zdVhEN05wRXFHMGRWS3dWWGRmaHptMDNidmhXV2NwOG5veFpjcGxP?=
 =?utf-8?B?QXBFMlhWY1VxKzJMc0hha1pOdWx5V1BDN00wRDhUYWtVNlg5M3ZSMmF0azV4?=
 =?utf-8?B?Vnd1WVpaZUhuMEUyZi80Q3NrOHNnN0dUWXRTQklGU0xWeWkrVHl2eVNsdmdM?=
 =?utf-8?B?U01NZjU0b2NKOHpCREZwdnhqSmRYc0RIMGF1R1JWTVkxUGdzVlJZQnlEbUhZ?=
 =?utf-8?B?Q0tLL3B4WlJVR0VQYUZSUHFSdDl0dkFibVcya1JnOTFrWjR5Ly9NeWxMellT?=
 =?utf-8?B?SlI0TjF1b2U3cW9DWGJuM3Q3Tnl3bkZDc2JVZStKMUhReGhyVjYyZms1cldV?=
 =?utf-8?B?SStJNjlsS0dqYUV3Y1ZJRG5xWDVDOVY3UFRXS0JJU1U5T0tRNEJrSzI0MG5w?=
 =?utf-8?B?MXhSVXFGQkp6ZmJwNllnWmF2Y1J4THVwN0pXRGxteGNFbk52UmJOc1ZBUGJz?=
 =?utf-8?B?aTExMHpzUnFya0srVWFtV0xSeVRreFZ1QnNWTFk3VXlJTnEvN1JnQ0NHRi9U?=
 =?utf-8?B?eU1IcnI1OTBYN25mU1I0QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB6756.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmdMYTJqZzFWQ3ZmYUZzRGJsSVpzTWZJVzJOKy9KdGg1c0VXcjJROG9LSFBT?=
 =?utf-8?B?bXVnaE1melEzK3NNb2dMaWs2YTYrVjlGWHYrcVRld1Jkd21mVncyUmNnOE5w?=
 =?utf-8?B?TDRIdjVwYXhVWjladGZCMXUxN3hYZTV6eTRsbnpDZkR2T3U3aGNPcjhmVnJK?=
 =?utf-8?B?dnhFajVBTVZ5TGhNQmhDd000MVlyQ2c2Rm43czJ2ekQ0UzhjejJOeUZHZUpl?=
 =?utf-8?B?dmFUZGdKOE9YSnVKZWNlN1ZoUDdKTFI3RHhHWjVzYkI2cHlXT0RpUUxyOEU2?=
 =?utf-8?B?TjhPOFVib25BQWM3T0lqaDBlMXE2K3hYRUJETWNEQ1pubXZRRlQ1WUtDLzU4?=
 =?utf-8?B?TStuNGRPbEhGbkJCUmtiQWZuWHhVK0dPN0JXVXNZSTIvRlRnQ0hpTjh1S3hu?=
 =?utf-8?B?QW1HVk50WjFZMWhVaTNQTnRtUzBGdGV6cXU2SE1EejI0SjVxakx6SGNPekVJ?=
 =?utf-8?B?TjBWVHVGUDkzWExzVnNyNmlPWktySkl5dmVMK3R3WEZ5bUgxclJVYnI4dExM?=
 =?utf-8?B?eE92RzFWcno1ZTNNSkFncXl4Uk03ZGZ5UVo2U3VFdC9FNzZmc2lnSWpRdmhu?=
 =?utf-8?B?cnJOYzdqYm1EUnk3MCtIS2VhS0FFUWlaRTAzOURPb1hVd0ZDMmZCd2ZMa3ZN?=
 =?utf-8?B?QzkxMllHTnVjeXJXZHoyUHBIMC9meVZqOCt0UldFa1g4cVNWcXNTQ0Q2NEV4?=
 =?utf-8?B?VG9BSWt6Y0VGTGYyQ2ZZcmNHTVB6Rll1MGVIR2lkU3VZL205UmJrSFNIN1l3?=
 =?utf-8?B?dXVQTEw5NmllZEVCckw2UVJ5Tm5tQ3lXdnZVWC9GL0Y4VkhMZnlnK0pLYW55?=
 =?utf-8?B?QzBBbmFxc2FSN1ZGaFFNSEd4ZGQvQXRScEkyQ3A4L01Qd2l1UWdNc01reUJo?=
 =?utf-8?B?QjNRTnlpQVNrR3puTHFwejdjZzNKWGV6bjRSeVE3Vm1pVWYxZERNeTZHNDNo?=
 =?utf-8?B?aHcwaklzL1FIUmw2S3lHc0QwdzJWd25NLzhaOW9MTG1QbXI2b1JBaWxHT1p0?=
 =?utf-8?B?blFXem94NGlyS2YyczI4UUZMVjFGV1c3UktHL1VpWm9XajVFNUF0TThGMFN1?=
 =?utf-8?B?a1Q5SXJpUU1FcndPTzBQN1podTZheVdMV2tQc0d5aEx1N3psd3cwOE9ENStj?=
 =?utf-8?B?SnNmeUZKYlB1WUJMMkVvQS9DWHozc2c0VnFkVkxJT1ZoOFRoVW1oNkNHdUdU?=
 =?utf-8?B?Zy9ZTTY1T2ZpdExUL1JXYWp3eEl1RmltNmlGcHE2bHFrb0JkWEZJZ09tbDNF?=
 =?utf-8?B?QzZ4Ukk4OFViRkxtVC81Um1WSFZLVHVMd3ZSUmZLZzdFbU5RU29jSlB4SzUr?=
 =?utf-8?B?dkhiS2hmT0ZUVHR0UG43NVU0ME5UYnkzbzN4ekZJVG8ramhBR0lHUU1PbkdD?=
 =?utf-8?B?cHZsVHBQU1dFV280ckFubmxOS3A1MFQ1NVg1ZERvWVdZQzFhTG4wc1Z0QnNo?=
 =?utf-8?B?QnYvcUpTY1BvSEJYMVgvVkIyNXVZMW8xc3NnOGQ3VWVsOHArWXREYlM2QnJt?=
 =?utf-8?B?MzYvL3pSQ2h2emdzV3JCUWJ2K25MMW1qMGxwdXNQMHAzZkdOTVgyc0Voa3h3?=
 =?utf-8?B?UmthVjF6TlVtOFM1RTBtc0ZVdWVHRTBMb0liWkpuM1NweDVPNFUxNkthVVZU?=
 =?utf-8?B?ZmFvamdHS29rUUxKTUN2K05nQWtXQXN1UWVaejM2VDRwSCtSVnZJSEhrL3lt?=
 =?utf-8?B?eGU5cmFnZ1JxV0hzTjlHVzJmZHRIbnRPcjBybkVodUhEUXRWemRMQk1La2k2?=
 =?utf-8?B?OWJHWXdLSGd6a09DZ095MllJM3gvNWxON05SRXg4dGpTOUh3UlpPeWp4d3lx?=
 =?utf-8?B?T3RMU3ZxOUZXK0NBOHgzSDdMc2F5enpYZm9PUlg5a1B3TkJXbnNDNFp1YndT?=
 =?utf-8?B?aDBNZ3hVQTd0RE5JbHBLejE0L2VTcGtZMGx6aTQ4ZU93bjZyMkdjTG0zUVZN?=
 =?utf-8?B?YTlWTlhKQW1uenQ2dVhOTkUxOTNkTkVtN2xCMnFVZmRSUFN1aHlpY01remM0?=
 =?utf-8?B?NFVta3BkWHRHcVZSaDlqZFBFRDJyNU0raVdza1ZrbzBCYllPL0dEY1d5c0gy?=
 =?utf-8?B?czczRnBmZ2FmV0RKdzRLTzk4VkprOUlOMG1MeXZmSHdZWnFZT0tlbEEycXVX?=
 =?utf-8?Q?N05MZUG7pArVaeqSHvYFvqr5V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5cff0a-d8ae-4f2d-6a79-08dc62b10b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 09:46:11.9927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUAdpvDTx0uWfs/1YC9FU6gWnxXpzb7xyoN6rTFPLaxKL5q3+UvmzTPA9Qm1v78vVvev485bOd/idFtwExKtai1aOJJJY88QZ9Eq4UGyVDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5545
Received-SPF: pass client-ip=40.107.215.139;
 envelope-from=gavin.liu@jaguarmicro.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

SGkgTWljaGFlbCwgVGhvbWFzDQoNClRoZSByZWFzb24gaXMgSSB3YW50IHRvIG1lcmdlIHRoaXMg
cGF0Y2g6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9TRVlQUjA2TUI2NzU2MUFCRDgzNjMz
Njg5QjUwMzczOTVFQzA2MkBTRVlQUjA2TUI2NzU2LmFwY3ByZDA2LnByb2Qub3V0bG9vay5jb20v
DQpDb21waWxhdGlvbiBlcnJvcnMgb2NjdXIgZHVyaW5nIENJIDoNCglzdGRlcnI6DQoJCSoqDQoJ
CUVSUk9SOi4uL3Rlc3RzL3F0ZXN0L3Zob3N0LXVzZXItdGVzdC5jOjQ2ODpjaHJfcmVhZDogYXNz
ZXJ0aW9uIGZhaWxlZCAoZXJyID09IE5VTEwpOiBCYWQgZmlsZSBkZXNjcmlwdG9yIChnLXVuaXgt
ZXJyb3ItcXVhcmssIDApDQoJCSoqDQoJCUVSUk9SOi4uL3Rlc3RzL3F0ZXN0L3Fvcy10ZXN0LmM6
MTkxOnN1YnByb2Nlc3NfcnVuX29uZV90ZXN0OiBjaGlsZCBwcm9jZXNzICgvYWFyY2g2NC92aXJ0
L2dlbmVyaWMtcGNpaG9zdC9wY2ktYnVzLWdlbmVyaWMvcGNpLWJ1cy92aXJ0aW8tbmV0LXBjaS92
aXJ0aW8tbmV0L3ZpcnRpby1uZXQtdGVzdHMvdmhvc3QtdXNlci9taWdyYXRlL3N1YnByb2Nlc3Mg
WzIyMTk3XSkgZmFpbGVkIHVuZXhwZWN0ZWRseSAodGVzdCBwcm9ncmFtIGV4aXRlZCB3aXRoIHN0
YXR1cyBjb2RlIC02KSDigJXigJUgDQoNClRoZSByZWFzb24gaXMgdGhhdCB3aGVuIHRoZSBndWVz
dCBvcyB1c2VzIHRoZSBQTUQgbW9kZSwgaXQgZG9lcyBub3QgZW5hYmxlIGludGVycnVwdHMgaW4g
dGhlIGRldmljZSdzIE1TSVguDQpJbiBRRU1VLCAgVGhlIGZ1bmN0aW9uIHZob3N0X3VzZXJfc2V0
X3ZyaW5nX2NhbGwgaW52b2tlcyB2aG9zdF9zZXRfdnJpbmdfZmlsZSB0byBzZW5kIHRoZSBmaWxl
IGRlc2NyaXB0b3IgaW5mb3JtYXRpb24sIHdoZXJlIGZkPS0xLCB0aHVzIGZkX251bT0wLg0KSW4g
Q0kgLCB0ZXN0cy9xdGVzdC92aG9zdC11c2VyLXRlc3QNCiAgIDHvvJp2aG9zdC11c2VyLXRlc3Qg
aW52b2tlcyB0aGUgY2hyX3JlYWQgZnVuY3Rpb24gdG8gaGFuZGxlIHRoZSBtZXNzYWdlcyBzZW50
IGJ5IHRoZSBzZXJ2ZXIuDQogICAy77yaVGhlIGNocl9yZWFkIGZ1bmN0aW9uIGluaXRpYWxpemVz
IHRoZSBsb2NhbCB2YXJpYWJsZSBmZCB0byAtMS4NCiAgIDPvvJoNCiAgICAgICAgY2FzZSBWSE9T
VF9VU0VSX1NFVF9WUklOR19DQUxMOg0KCQkJcWVtdV9jaHJfZmVfZ2V0X21zZ2ZkcyhjaHIsICZm
ZCwgMSk7IA0KCQkJDQohISEgQmVjYXVzZSBzLT5yZWFkX21zZ2Zkc19udW0gPSAwLCBhZnRlciB0
aGUgZnVuY3Rpb24gcWVtdV9jaHJfZmVfZ2V0X21zZ2ZkcyhjaHIsICZmZCwgMSkgaXMgZXhlY3V0
ZWQsIGZkPS0xLiEhIQ0KDQoJCQlnX3VuaXhfc2V0X2ZkX25vbmJsb2NraW5nKGZkLCB0cnVlLCAm
ZXJyKTsgDQoJCQkNCiEhISBBbiBleGNlcHRpb24gd2lsbCBvY2N1ciB3aGVuIHNldHRpbmcgbm9u
YmxvY2tpbmcgd2hlbiBmZCA8IDAuICEhIQkNCgkJCWdfYXNzZXJ0X25vX2Vycm9yKGVycik7DQoN
CgkJCQkJCQ0KT2ZmZXIgYSBtb2RpZmljYXRpb24gc3VnZ2VzdGlvbg0KICAgMe+8mlJlZmVyIHRv
IHRoZSB0Y3BfY2hyX3JlY3YgZnVuY3Rpb246DQoJCQkJCQlzdGF0aWMgc3NpemVfdCB0Y3BfY2hy
X3JlY3YoQ2hhcmRldiAqY2hyLCBjaGFyICpidWYsIHNpemVfdCBsZW4pDQoJCQkJCQl7DQoJCQkJ
CQkJU29ja2V0Q2hhcmRldiAqcyA9IFNPQ0tFVF9DSEFSREVWKGNocik7DQoJCQkJCQkJICAtLS0t
LQ0KCQkJCQkJCSAgLS0tLQ0KCQkJCQkJCWZvciAoaSA9IDA7IGkgPCBzLT5yZWFkX21zZ2Zkc19u
dW07IGkrKykgew0KCQkJCQkJCQlpbnQgZmQgPSBzLT5yZWFkX21zZ2Zkc1tpXTsNCgkJCQkJCQkJ
aWYgKGZkIDwgMCkgew0KCQkJCSEhISFXaGVuIGZkIDwgMCwgdGhlIHFlbXVfc29ja2V0X3NldF9i
bG9jayBmdW5jdGlvbiB3aWxsIG5vdCBiZSBjYWxsZWQgISEhIQkJCQ0KCQkJCQkJCQkJY29udGlu
dWU7DQoJCQkJCQkJCX0NCg0KCQkJCQkJCQkvKiBPX05PTkJMT0NLIGlzIHByZXNlcnZlZCBhY3Jv
c3MgU0NNX1JJR0hUUyBzbyByZXNldCBpdCAqLw0KCQkJCQkJCQlxZW11X3NvY2tldF9zZXRfYmxv
Y2soZmQpOw0KDQoJCQkJDQogICAyOiBtb2RpZnkgY2hyX3JlYWQgZnVuY3Rpb24gDQoNCgkJCQlj
YXNlIFZIT1NUX1VTRVJfU0VUX1ZSSU5HX0NBTEw6DQoJCQkJCQlxZW11X2Nocl9mZV9nZXRfbXNn
ZmRzKGNociwgJmZkLCAxKTsgDQoJCQkJCQlpZiAoZmQgPDApICAgLyogQWRkIGEgY29uZGl0aW9u
IGNoZWNrLiAqLw0KCQkJCQkJCWJyZWFrOw0KCQkJCQkJZ191bml4X3NldF9mZF9ub25ibG9ja2lu
ZyhmZCwgdHJ1ZSwgJmVycik7IA0KCQkJCQkJZ19hc3NlcnRfbm9fZXJyb3IoZXJyKTsNCg0KQmVz
dCByZWdhcmRzLA0KWXV4dWUgTGl1DQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IE1pY2hhZWwgUy4gVHNpcmtpbiBtc3RAcmVkaGF0LmNvbQ0KU2VudDogQXByaWwgMTgsIDIw
MjQgMjM6NDENClRvOiBHYXZpbiBMaXUgZ2F2aW4ubGl1QGphZ3Vhcm1pY3JvLmNvbQ0KQ2M6IHBi
b256aW5pQHJlZGhhdC5jb207IGx2aXZpZXJAcmVkaGF0LmNvbTsgdGh1dGhAcmVkaGF0LmNvbTsg
cWVtdS1kZXZlbEBub25nbnUub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSB2aG9zdC11c2VyLXRl
c3Q6IG5vIHNldCBub24tYmxvY2tpbmcgZm9yIGNhbCBmZCBsZXNzIHRoYW4gMC4NCg0KDQpFeHRl
cm5hbCBNYWlsOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBPVVRTSURFIG9mIHRoZSBvcmdh
bml6YXRpb24hDQpEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0YWNobWVudHMgb3IgcHJvdmlk
ZSBBTlkgaW5mb3JtYXRpb24gdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCk9uIFRodSwgQXByIDExLCAyMDI0IGF0IDAzOjM1
OjU1UE0gKzA4MDAsIFl1eHVlIExpdSB5dXh1ZS5saXVAamFndWFybWljcm8uY29tIHdyb3RlOg0K
PiBGcm9tOiBZdXh1ZSBMaXUgPHl1eHVlLmxpdUBqYWd1YXJtaWNyby5jb20+DQo+DQo+IEluIHRo
ZSBzY2VuYXJpbyB3aGVyZSB2aG9zdC11c2VyIHNldHMgZXZlbnRmZCB0byAtMSwgDQo+IHFlbXVf
Y2hyX2ZlX2dldF9tc2dmZHMgcmV0cmlldmVzIGZkIGFzIC0xLiBXaGVuIHZob3N0X3VzZXJfcmVh
ZCANCj4gcmVjZWl2ZXMsIGl0IGRvZXMgbm90IHBlcmZvcm0gYmxvY2tpbmcgb3BlcmF0aW9ucyBv
biB0aGUgZGVzY3JpcHRvciANCj4gd2l0aCBmZD0tMSwgc28gbm9uLWJsb2NraW5nIG9wZXJhdGlv
bnMgc2hvdWxkIG5vdCBiZSBwZXJmb3JtZWQgaGVyZSANCj4gZWl0aGVyLlRoaXMgaXMgYSBub3Jt
YWwgdXNlIGNhc2UuIENhbGxpbmcgZ191bml4X3NldF9mZF9ub25ibG9ja2luZyBhdCANCj4gdGhp
cyBwb2ludCB3aWxsIGNhdXNlIHRoZSB0ZXN0IHRvIGludGVycnVwdC4NCj4NCj4gV2hlbiB2aG9z
dF91c2VyX3dyaXRlIHNldHMgdGhlIGNhbGwgZmQgdG8gLTEsIGl0IHNldHMgdGhlIG51bWJlciBv
ZiANCj4gZmRzIHRvIDAsIHNvIHRoZSBmZHMgb2J0YWluZWQgYnkgcWVtdV9jaHJfZmVfZ2V0X21z
Z2ZkcyB3aWxsIGFsc28gYmUgDQo+IDAuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFl1eHVlIExpdSA8
eXV4dWUubGl1QGphZ3Vhcm1pY3JvLmNvbT4NCg0KQSBiaXQgbW9yZSBkZXRhaWwgaGVyZSBwbGVh
c2UuDQpXaGVuIGRvZXMgYWxsIHRoaXMgaGFwcGVuPw0KDQo+IC0tLQ0KPiAgdGVzdHMvcXRlc3Qv
dmhvc3QtdXNlci10ZXN0LmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC92aG9z
dC11c2VyLXRlc3QuYyANCj4gYi90ZXN0cy9xdGVzdC92aG9zdC11c2VyLXRlc3QuYyBpbmRleCBk
NGU0MzcyNjVmLi43YzhlZjYyNjhkIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xdGVzdC92aG9zdC11
c2VyLXRlc3QuYw0KPiArKysgYi90ZXN0cy9xdGVzdC92aG9zdC11c2VyLXRlc3QuYw0KPiBAQCAt
NDU4LDcgKzQ1OCwxMCBAQCBzdGF0aWMgdm9pZCBjaHJfcmVhZCh2b2lkICpvcGFxdWUsIGNvbnN0
IHVpbnQ4X3QgKmJ1ZiwgaW50IHNpemUpDQo+ICAgICAgY2FzZSBWSE9TVF9VU0VSX1NFVF9WUklO
R19LSUNLOg0KPiAgICAgIGNhc2UgVkhPU1RfVVNFUl9TRVRfVlJJTkdfQ0FMTDoNCj4gICAgICAg
ICAgLyogY29uc3VtZSB0aGUgZmQgKi8NCj4gLSAgICAgICAgcWVtdV9jaHJfZmVfZ2V0X21zZ2Zk
cyhjaHIsICZmZCwgMSk7DQo+ICsgICAgICAgIGlmICghcWVtdV9jaHJfZmVfZ2V0X21zZ2Zkcyhj
aHIsICZmZCwgMSkgJiYgZmQgPCAwKSB7DQo+ICsgICAgICAgICAgICBxb3NfcHJpbnRmKCJjYWxs
IGZkIDolZCwgbm8gc2V0IG5vbi1ibG9ja2luZ1xuIiwgZmQpOw0KPiArICAgICAgICAgICAgYnJl
YWs7DQo+ICsgICAgICAgIH0NCj4gICAgICAgICAgLyoNCj4gICAgICAgICAgICogVGhpcyBpcyBh
IG5vbi1ibG9ja2luZyBldmVudGZkLg0KPiAgICAgICAgICAgKiBUaGUgcmVjZWl2ZSBmdW5jdGlv
biBmb3JjZXMgaXQgdG8gYmUgYmxvY2tpbmcsDQo+IC0tDQo+IDIuNDMuMA0KDQo=

