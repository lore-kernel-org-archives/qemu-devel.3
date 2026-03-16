Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECC6F46449
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25Wz-0002Oc-F8; Mon, 16 Mar 2026 06:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w25Wx-0002Mh-EJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:50:39 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w25Wv-0005eb-OS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGdzJHdbN6fgR6g3XPPNk6rFD0I1SemOFYdFO5UGHezi5HwZ5uljq3+gqG37A0PW2E5hSfuQjgEASjQzrRZViWW4VQK/CrKPjJ6+OgVGWUsMZDNtZiA3bg67ws4J2kHMxs0C4zj7LPRir763XFuaBc1e1zzJfbe6w3LCAJ0GxkkPHMkNM3XJYqcOYbbNcmhduN/tlpja67q4fQgxCksk3MFH9BbAGDXtJo575jr3f8abg2652ttYDT1VtrIB2Ral4X4GunHgnQb0UbEDZuA5s7odeCF/Xol+si2oL8DN3qG5H76ZNNcyCh30ln6EXHcpWLPsraM8XuuYNQmxIJVENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73SwN+zhT87ZkdoAZaxIMjt4x2cLNPEfiVpWT9tHWx4=;
 b=omeY1ZspOZVikuQs4rd6FNNsL9KeVmpBZnVZV/7U8/qwx4ix9INlzQiJSVSzAKHYIx5YSAo+fhYXhS/AjUZ8N4vGa8gFMcrIeFAo/FTWfN4ynPl/I8r1cYlqPfsAPAQAbqsdvgCcN9h5A0f9T3Bxpy5MWrPH04xhigH0iFibW9f9QO+3HYcVpD5XlKbTzLeqTV1NfCp8tpK2zi49zPA1/QrXClzjpzsd3Iq80aVmLa866D9lJeVSJqA5SA12vmDYp87iNQrTQCRSCJgjQ5C56wRtS9QnYFlKZ83s3C1S8al3z1Xu5Nh4sLoszpcCzMmHZSsLMJoYv7SXJR+8C72kQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73SwN+zhT87ZkdoAZaxIMjt4x2cLNPEfiVpWT9tHWx4=;
 b=so/sfUHVB3YQj7CEXcvFP2HuTDkG8Urgt1vwrFyOYgTqV69/61xwNoNGyrgE9SXqajcB8efaq90eNBz4Hf4zxD3gmdsG9DxRg6AlOmhEurjas4/fH3F8zXOyooKgQeqdyyPloZpUGu7h2EXvt+lXCxJzLmog8i/eCLMJj4Pj4Ur0bX9BECdgIfB5Dhd23I4RAkqZB6NLHkXJBaR62XnfqPJKEHhlbNBHGRsPbjQyeaQKE1DlSeu/HGsK/eSEzjtTlQSlM/+papwldxyyRPYd6l1GUUEyY/J7TSVjtsQ7FCnbIa5gkEwJCtbBnqQcuU0EdcRIYtmofw71YAM/HB9f3Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 10:50:31 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 10:50:31 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Nicolin Chen <nicolinc@nvidia.com>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PULL 14/43] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Thread-Topic: [PULL 14/43] hw/arm/smmuv3-accel: Add nested vSTE
 install/uninstall support
Thread-Index: AQHctTC2XmBcf5gFP02ArB2ufp2QM7Ww+DZQ
Date: Mon, 16 Mar 2026 10:50:31 +0000
Message-ID: <CH3PR12MB75485C08E7F94A214998914CAB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
 <20260129160917.1415092-15-peter.maydell@linaro.org>
 <CAFEAcA-AoJmHpcAydqk9x_Y6M8_7N=7-izYFPxerLuTdYUKsNg@mail.gmail.com>
 <CAFEAcA99c+-qQX+wfVTZ5bKeYozm+WrFHsb=GEQriu_SuWjhWQ@mail.gmail.com>
 <671d4604-9656-4f74-961c-88f447058858@redhat.com>
In-Reply-To: <671d4604-9656-4f74-961c-88f447058858@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA3PR12MB7858:EE_
x-ms-office365-filtering-correlation-id: c3de98ce-b79d-4521-08ee-08de8349d7f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: LOwhXmwFBl+37rGmuUroGIJeH9Pn+jHzWW5zojE+eoJBrNHfmoGcjbi1KLA1KKTkKpUeGQ86yVWI3WMtxZ2DH2JgkmUKjzVOurBIGa1EldXR5UWsE/OyEsnF/lAR4YcWIVAIe2x47L+u4CxNgbBGYOXuGRffqulBDG9Gbc8QM9cIIDO2kXVKdY9k7NApFuAKeawL+vcZ3nqTHqkFfRvwXch8wuWvfYIuRxEx+w2OaiPB0dk/H2f+04tjJZ+d4AqGtrO861QSkD2e0D2Mx2VubntPcKzUHNN4hnHEv/PIpNwZEVepu1j5c5O0/vhpsZkedV/6gc0NJ8pKpA9ciinBFNjoNISmh/GY0nPbY5L3lESrnAqmIS951oC+jabrpO8PvZfPebZuTruEQwTWT6SiGxkjQ4rpEd0ZjPCOAidM8Rn5dd5QlZep2SIgo+xh9ntCYohRGH4jbfC0NsDuxVPeLeushi9tJw+H/Yro4kA+MKJuVcfMaCNSq5cXs3o9KQY5C3LqScN6lG8yiMG1dbKPrrR+7Y9GzYy0SI1h+ZoqMI7Q6MSN9YSXuPWhuP7kaHMUmvu48M8Ofaf/nxOHaZmhtrMplJxV11VkMv63IaYeg2zDLANMyT9KGQ47Uwm6oP3jdz/p7SBsZidHG5TB+PpRX5czlGLpvFIxWXgYyHXHDk/vK2NA6FGvzokXtyxfqR0qEK2xFzAPBBvG3+eTxk+oJZksgrk9VlzaVp2bOeg4bvDv7DPirkueC6oIjL6UsV9oW18FuCMWiTdc4kgCushHU1Ig5Tg/vyhLlrm+SphlsiQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmgrWmd3MnJheFNTSXdGWHBBV1lkQzhxSDlVeHdveVArTDltdWgzRTJuQ3BO?=
 =?utf-8?B?MzlYWTk1L2lqWURPVU1yYWE1TFRHZWNsaHZwQVRIVWt2MXRqcGd6ODVGYWNV?=
 =?utf-8?B?QUFUeUFOY2I0K1dkNzFXSVYxeEZZWnFuM2FqRG9KckRqOG5IT3BUcDFmOVJz?=
 =?utf-8?B?Qll1Umg4TFVBNDZvaHZoU3EwVXR1WTZnQi90UE9ML3ZqWjBucnF3eGhrU1Nh?=
 =?utf-8?B?Uld0U3cvYWFKTnRSU29sWi9sdExoZUNWUzZ0dVRuQjJJVDZ5ZGNiL0srRmIx?=
 =?utf-8?B?dzlqTngwcXN6VzAyVFdRRkh2Z0RjYzhJbTRPRkpjZ1d0WWtTeXZDakZDQUx3?=
 =?utf-8?B?YnN6ak5qQnVlWEQ3TWlIYTRpOVZiN2RxNGZSaE1NQXA5WDlLU09ob0IvVTJS?=
 =?utf-8?B?NzBrK0pYTXMwRjlHNFErelFtRURhUFRUK1J5cTNmanlxUUc1b0pNUHh1Uk5t?=
 =?utf-8?B?Slg2WDRURHRvRWU0dEZ3aXlWNmlmZFgwRTd3R0crUVpmR3k3NmNSTUkwb3dX?=
 =?utf-8?B?MFM0QlA3c1V5UWhHSGYrMnJOVk9IR3QvZ3ZZcHpVRC9kU2srNEpDZU5vRVZJ?=
 =?utf-8?B?Und5cVRSTnZyeG9oQVMra3g5bkg1L0E3TXlKVUIwb1RpL1BONmgwaHkwNzVH?=
 =?utf-8?B?RCtuZ2RUSytJZGVzSEJPT2tvbHJpNjNaVWgycWxhWnJnbzB6MkRoS0s1RzdH?=
 =?utf-8?B?ZFlzSmo1UCtZeDhscEVvdFdJelhaK3k4Y01QYVRFb1BMSUFPdGFLdGx1YkFC?=
 =?utf-8?B?c0tqT1FsNFhqOExFaFh4MGVOL3hYbDFWSlUvSTBoYUhENDJqWEdQUzNBN3I1?=
 =?utf-8?B?U1hZNThRVW1WNXhCUWtRYjEvQU54TEFZWERYb09nWFd5eGl3NjlNVGZSV09s?=
 =?utf-8?B?RHN3NkM4UEx5Yjc5T1cycWlwQUVkTjZ5NmZwTDFwSUo0dUs0VjY4WTIvWmw2?=
 =?utf-8?B?QW1NSHNKWlZzWDNVZnV5T201eWUwODdGK2s0VXRTb0I1WlRxclBiNjgzVS9Z?=
 =?utf-8?B?dzBoR0JRU0ZBbW9icTFwVEFGVFBHMlRrZXlSWmhYMnRVRjQ1SnhOd1A0MW5S?=
 =?utf-8?B?cVVCbnhwc1JZeE9XNkJCWXlOOWc0UDRyTXNqRE90L2ljK3Fid2tXL29JTTU0?=
 =?utf-8?B?MXh1TVZXT1N1K2NOTHNpQUFuQ2VyWldEWlp2UlpYOTBFTk9JYjMrV29KN1Bm?=
 =?utf-8?B?dW9pOXoxNWNrQlJkVlgwOTZWdXo5QkdtMnFDVTdaM3FlaXlFVGlQMlVwYWZt?=
 =?utf-8?B?cU13UVFRREpUa2xhYWkrZDYvdFc3d3dPWGpacE14eXpvMEdUR1dOcVZUYyth?=
 =?utf-8?B?dGxsaHBzeGhHQkVHN2xsK3NwdHdONFJybUNyejNCZUJhMmdUdWE2SUJVd1Qx?=
 =?utf-8?B?aldRYVNyTFdWcUVSUnlzWXlPOGZyaUx2cmhFalRPZUVOSzZSUmt0T3AyMUt0?=
 =?utf-8?B?Qml0MVFYWkxiVXNJQ0ZzWE50cjd3eVhWQVo3anFOcDNQTThNNElXNEpURmpx?=
 =?utf-8?B?M25SbW1UdnNMZlFLNkVVdDRwOWV3QVcrRmFXd2lzMzlNdHQ0RTZQT0c4QVF1?=
 =?utf-8?B?dFpBZjF6V2VZMG9xYUE1cUlqVU1BQlQzbk0yNjF3Uk41MGxETlF1R2NPR0Fr?=
 =?utf-8?B?Yk1GSVZzZXhaakFJMzZmYmJNOW9wRlB5SlNleTBWaHBFVFZocGhVaC9IeDQ2?=
 =?utf-8?B?MWVrdWMxcVRkSjh3VTdLbXhaR2NQWDRUQWtuVlBTVW4vZ1VpRTFYZEI5SmhS?=
 =?utf-8?B?RDlNbmQyU1ZtN095ajdXWjQ3TEViZE1ERkdZUXFnWHlHSkJFQ21yU1NlcGhu?=
 =?utf-8?B?amlOUU50dnVVQTN2T1Bxb0FsNUZTR0NyVFh1bWFvVUl6RUZjbFQxeXJjaUlm?=
 =?utf-8?B?Uk1WR1JlUE1NZ1AxN2c5ZDk3Vm5BdGtxVWtCbThOZHJWb0NrdjBNRlc1VnhU?=
 =?utf-8?B?M0FhZzJqN0hjcGowMTFLZXI0MHRRRThjRTl3VVI3MFVsN09SdzZOWEl6ZVgy?=
 =?utf-8?B?c3pzaVg5aFIzMmtqQ2dKT0YwS1Y5U0FwdVExN1R1SGtCOEZvUjlTN1VKOWsy?=
 =?utf-8?B?eGp2RlR3SWVtU1VTNWUxZStBdDVka05TMk9iWEQ5U3k4VEYrcnV6YWNhQk1E?=
 =?utf-8?B?UTEwR3U5Sy9BcXBtRktYNGVGN3BrYm90OCs2WXplRC9Ec012WGZZM09VZ3N0?=
 =?utf-8?B?T041akVyZUpTbmQvL2FSTjFzRWZXaWtuMzh4Tm1JSDFSWDJxQ2E5MENqdkZk?=
 =?utf-8?B?d0xhTDBsUGV4SE05TXhaQ1ZQd1NOVk5ub3Ezc0haZlRlVmxZR3RkWklnNnQ1?=
 =?utf-8?B?YjlVRmxnTGRDbGhzSFFDZUFKYmM4YzZYN0x0SjdFa3duU0JBc2l0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3de98ce-b79d-4521-08ee-08de8349d7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 10:50:31.1778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vEfppKkapRCYwjmpOsM+zmOQM/jD7FQNSBvRiO4aLQ1Y4Us5uQbK69XQvN6/cxSMT6KNMutRek1vhWW86rAuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxNiBNYXJjaCAyMDI2IDEwOjM2DQo+IFRvOiBQ
ZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBxZW11LWRldmVsQG5vbmdu
dS5vcmc7DQo+IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IFNoYW1lZXIgS29s
b3RodW0gVGhvZGkNCj4gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzogSm9uYXRoYW4g
Q2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BV
TEwgMTQvNDNdIGh3L2FybS9zbW11djMtYWNjZWw6IEFkZCBuZXN0ZWQgdlNURQ0KPiBpbnN0YWxs
L3VuaW5zdGFsbCBzdXBwb3J0DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3Bl
bmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDMvMTMvMjYgMzowNiBQTSwg
UGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gPiBQaW5nIGZvciBvcGluaW9ucyBvbiB3aGV0aGVyIENv
dmVyaXR5IGlzIHJpZ2h0IGFib3V0IGEgbGVhayBoZXJlLi4uDQo+ID4NCj4gPiB0aGFua3MNCj4g
PiAtLSBQTU0NCj4gPg0KPiA+DQo+ID4gT24gVHVlLCAxNyBGZWIgMjAyNiBhdCAxNDoyNCwgUGV0
ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiB3cm90ZToNCj4gPj4gT24g
VGh1LCAyOSBKYW4gMjAyNiBhdCAxNjowOSwgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPg0KPiB3cm90ZToNCj4gPj4+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNA
bnZpZGlhLmNvbT4NCj4gPj4+DQo+ID4+PiBBIGRldmljZSBwbGFjZWQgYmVoaW5kIGEgdlNNTVUg
aW5zdGFuY2UgbXVzdCBoYXZlIGNvcnJlc3BvbmRpbmcNCj4gPj4+IHZTVEVzIChieXBhc3MsIGFi
b3J0LCBvciB0cmFuc2xhdGUpIGluc3RhbGxlZC4gVGhlIGJ5cGFzcyBhbmQgYWJvcnQNCj4gPj4+
IHByb3h5IG5lc3RlZCBIV1BUcyBhcmUgcHJlLWFsbG9jYXRlZC4NCj4gPj4+DQo+ID4+PiBGb3Ig
dHJhbnNsYXQgSFdQVCwgYSB2REVWSUNFIG9iamVjdCBpcyBhbGxvY2F0ZWQgYW5kIGFzc29jaWF0
ZWQgd2l0aA0KPiA+Pj4gdGhlIHZJT01NVSBmb3IgZWFjaCBndWVzdCBkZXZpY2UuIFRoaXMgYWxs
b3dzIHRoZSBob3N0IGtlcm5lbCB0bw0KPiA+Pj4gZXN0YWJsaXNoIGEgdmlydHVhbCBTSUQgdG8g
cGh5c2ljYWwgU0lEIG1hcHBpbmcsIHdoaWNoIGlzIHJlcXVpcmVkDQo+ID4+PiBmb3IgaGFuZGxp
bmcgaW52YWxpZGF0aW9ucyBhbmQgZXZlbnQgcmVwb3J0aW5nLg0KPiA+Pj4NCj4gPj4+IEFuIHRy
YW5zbGF0ZSBIV1BUIGlzIGFsbG9jYXRlZCBiYXNlZCBvbiB0aGUgZ3Vlc3QgU1RFIGNvbmZpZ3Vy
YXRpb24NCj4gPj4+IGFuZCBhdHRhY2hlZCB0byB0aGUgZGV2aWNlIHdoZW4gdGhlIGd1ZXN0IGlz
c3VlcyBTTU1VX0NNRF9DRkdJX1NURQ0KPiA+Pj4gb3IgU01NVV9DTURfQ0ZHSV9TVEVfUkFOR0Us
IHByb3ZpZGVkIHRoZSBTVEUgZW5hYmxlcyBTMQ0KPiB0cmFuc2xhdGlvbi4NCj4gPj4+DQo+ID4+
PiBJZiB0aGUgZ3Vlc3QgU1RFIGlzIGludmFsaWQgb3IgUzEgdHJhbnNsYXRpb24gaXMgZGlzYWJs
ZWQsIHRoZQ0KPiA+Pj4gZGV2aWNlIGlzIGF0dGFjaGVkIHRvIG9uZSBvZiB0aGUgcHJlLWFsbG9j
YXRlZCBBQk9SVCBvciBCWVBBU1MgSFdQVHMNCj4gaW5zdGVhZC4NCj4gPj4+DQo+ID4+PiBXaGls
ZSBhdCBpdCwgZXhwb3J0IHNtbXVfZmluZF9zdGUoKSBmb3IgdXNlIGhlcmUuDQo+ID4+IEhpOyBD
b3Zlcml0eSBwb2ludHMgb3V0IHdoYXQgbG9va3MgbGlrZSBhIG1pc3NpbmcgZGVhbGxvY2F0aW9u
IG9uIGFuDQo+ID4+IGVycm9yLWV4aXQgcGF0aCBpbiB0aGlzIGZ1bmN0aW9uIChDSUQgMTY0NDgz
Mik6DQo+ID4+DQo+ID4+PiArYm9vbCBzbW11djNfYWNjZWxfaW5zdGFsbF9zdGUoU01NVXYzU3Rh
dGUgKnMsIFNNTVVEZXZpY2UgKnNkZXYsDQo+IGludCBzaWQsDQo+ID4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKSB7DQo+ID4+IFsuLi5dDQo+ID4+DQo+ID4+
PiArICAgIC8qDQo+ID4+PiArICAgICAqIEluc3RhbGwgdGhlIFNURSBiYXNlZCBvbiBTTU1VIGVu
YWJsZWQvY29uZmlnOg0KPiA+Pj4gKyAgICAgKiAtIGF0dGFjaCBhIHByZS1hbGxvY2F0ZWQgSFdQ
VCBmb3IgYWJvcnQvYnlwYXNzDQo+ID4+PiArICAgICAqIC0gb3IgYSBuZXcgSFdQVCBmb3IgdHJh
bnNsYXRlIFNURQ0KPiA+Pj4gKyAgICAgKg0KPiA+Pj4gKyAgICAgKiBOb3RlOiBUaGUgdmRldiBy
ZW1haW5zIGFzc29jaWF0ZWQgd2l0aCBhY2NlbF9kZXYgZXZlbiBpZiBIV1BUDQo+ID4+PiArICAg
ICAqIGF0dGFjaC9hbGxvYyBmYWlscywgc2luY2UgdGhlIEd1ZXN04oCTSG9zdCBTSUQgbWFwcGlu
ZyBzdGF5cw0KPiA+Pj4gKyAgICAgKiB2YWxpZCBhcyBsb25nIGFzIHRoZSBkZXZpY2UgaXMgYmVo
aW5kIHRoZSBhY2NlbGVyYXRlZCBTTU1VdjMuDQo+ID4+PiArICAgICAqLw0KPiA+Pj4gKyAgICBp
ZiAoIXNtbXVfZW5hYmxlZChzKSkgew0KPiA+Pj4gKyAgICAgICAgaHdwdF9pZCA9IHNtbXV2M19h
Y2NlbF9nYnBhX2h3cHQocywgYWNjZWwpOw0KPiA+Pj4gKyAgICB9IGVsc2Ugew0KPiA+Pj4gKyAg
ICAgICAgY29uZmlnID0gU1RFX0NPTkZJRygmc3RlKTsNCj4gPj4+ICsNCj4gPj4+ICsgICAgICAg
IGlmICghU1RFX1ZBTElEKCZzdGUpIHx8IFNURV9DRkdfQUJPUlQoY29uZmlnKSkgew0KPiA+Pj4g
KyAgICAgICAgICAgIGh3cHRfaWQgPSBhY2NlbC0+YWJvcnRfaHdwdF9pZDsNCj4gPj4+ICsgICAg
ICAgIH0gZWxzZSBpZiAoU1RFX0NGR19CWVBBU1MoY29uZmlnKSkgew0KPiA+Pj4gKyAgICAgICAg
ICAgIGh3cHRfaWQgPSBhY2NlbC0+YnlwYXNzX2h3cHRfaWQ7DQo+ID4+PiArICAgICAgICB9IGVs
c2UgaWYgKFNURV9DRkdfUzFfVFJBTlNMQVRFKGNvbmZpZykpIHsNCj4gPj4+ICsgICAgICAgICAg
ICBzMV9od3B0ID0gc21tdXYzX2FjY2VsX2Rldl9hbGxvY190cmFuc2xhdGUoYWNjZWxfZGV2LA0K
PiA+Pj4gKyAmc3RlLCBlcnJwKTsNCj4gPj4gSW4gdGhpcyBmdW5jdGlvbiB3ZSBhbGxvY2F0ZSBt
ZW1vcnkgYW5kIHJldHVybiBpdCwgYXNzaWduaW5nIGl0IHRvDQo+ID4+IHMxX2h3cHQuLi4NCj4g
Pj4NCj4gPj4NCj4gPj4+ICsgICAgICAgICAgICBpZiAoIXMxX2h3cHQpIHsNCj4gPj4+ICsgICAg
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+Pj4gKyAgICAgICAgICAgIH0NCj4gPj4+ICsg
ICAgICAgICAgICBod3B0X2lkID0gczFfaHdwdC0+aHdwdF9pZDsNCj4gPj4+ICsgICAgICAgfQ0K
PiA+Pj4gKyAgICB9DQo+ID4+PiArDQo+ID4+PiArICAgIGlmICghaHdwdF9pZCkgew0KPiA+Pj4g
KyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSW52YWxpZCBTVEUgY29uZmlnIGZvciBzaWQgMHgl
eCIsDQo+ID4+PiArICAgICAgICAgICAgICAgICAgIHNtbXVfZ2V0X3NpZCgmYWNjZWxfZGV2LT5z
ZGV2KSk7DQo+ID4+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4+IC4uLmJ1dCBpbiB0aGlz
IGVycm9yLWV4aXQgY29kZSBwYXRoIHdlIGRvbid0IGZyZWUgaXQuDQo+IHMxX2h3cHQgaXMgYWxs
b2NhdGVkIGlmIGlvbW11ZmRfYmFja2VuZF9hbGxvY19od3B0KCkgc3VjY2VlZGVkIGFuZCBpZiBp
dCBkaWQNCj4gaHdwdF9pZCBjYW5ub3QgYmUgTlVMTCBJIHRoaW5rLg0KPiBTaGFtZWVyLCBOaWNv
bGluLCBwbGVhc2UgY291bGQgeW91IGNvbmZpcm0NCj4gDQo+IEFkZGluZyBTaGFtZWVyIGluIFRP
DQoNClllcy4gSWYgczFfaHdwdCBpcyBhbGxvY2F0ZWQsIGh3cHRfaWQgY2Fubm90IGJlIDAuDQoN
CnMxX2h3cHQgaXMgb25seSByZXR1cm5lZCBhZnRlciBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdw
dCgpIHN1Y2NlZWRzDQphbmQgcHJvdmlkZXMgYSB2YWxpZCBod3B0X2lkLCB3aGljaCB3ZSBhc3Np
Z24gdG8gaHdwdF9pZCBpbW1lZGlhdGVseQ0KYWZ0ZXIuIFNvIHRoZSBsYXRlciAiIWh3cHRfaWQi
IGVycm9yIHBhdGggY2Fubm90IGJlIGhpdCBpbiB0aGF0IGNhc2UuDQoNClRoYW5rcywNClNoYW1l
ZXINCg==

