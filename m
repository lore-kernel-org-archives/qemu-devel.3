Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C68C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrD4B-00073R-FJ; Tue, 04 Aug 2026 07:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wrD49-00072e-Lx
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:12:13 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1wrD47-0001iy-Or
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1785841932; x=1817377932;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xFe9JEeiikZ41Rh+6qXHvwt1hqFBkD//iqrzhZsMAj8=;
 b=Azp8kxTfxHKk3dw9ry+YSiDpBIzXbrGd2DJAocCMYGZ3baZl6OkY8hu/
 xbKwppWhazTkhcOxLLh3NLhUFjJ44vTNa9UHCk9t7n1cdOyocjdXTAY1V
 p7tGKoydVRh/jaoCdOBgT1UMV0yJE/1r0+2U4C4o77XXfwjwugUMxF/sY
 Z/vT41tb1e4bbX3uS+IelHfSuiIt3VNcdOUkzU+qWcMUuEfbTHLBUqH4o
 43KRHwtcA1LLjYhZM+ZaTc1PKv+Io6TaP2hCHSF4b1tVL+neXjhfrPDKl
 F1ShmwOGaWDjsfAZNr4mj1CDOKaxO/x913/mfqlW/C+KMYFLJclcTKRwl g==;
X-CSE-ConnectionGUID: XO+lQg8lQau7rkzMquQNkw==
X-CSE-MsgGUID: I+EuSqXJRFaGCgQsyzmaCg==
IronPort-SDR: 6a71c908_0KvsLTckeEqLuJhueidAP24AqQNYMOEkzzzAkUOxBh/iRJS
 E5CVLWFq6ZDGaqfWVa2SIGj4YKaCRHc7U6yk8/Q==
X-IronPort-AV: E=Sophos;i="6.25,204,1779141600"; d="scan'208";a="48538821"
X-MGA-submission: =?us-ascii?q?MDG6TrqUVa1yLmxmhpzXSHxFv6E/rotUzMMZHH?=
 =?us-ascii?q?zd0ud9yWt0/nBoPbiCjWOaIcb4LzV3A2N8CCM5kvQpcGpiID/G29bizw?=
 =?us-ascii?q?WckTT8BLZ5ndZRyhv550laxOljJ6R37H2pZR/xQBAyR6xqBsQT7yiJn3?=
 =?us-ascii?q?6Z3iPzqJyKTMsr/EHkdaiI1A=3D=3D?=
Received: from mail-westeuropeazon11010035.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.35])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 04 Aug 2026 13:12:08 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjZMY3CYUOvPSAq9dVzKPqlhcLdHn0RgDu0QQdafL6VFsV+eaI5h65hUWO6BsKllY4gk/iLHvh771T2brMUgSM4QW93dwmbKg3TXDYYW69h761KvWyDYTTrxENr4sZn3KJm/AUK1Z048YfE3OTRo50XX+zIb4XV56T9Hs2874+zk8GvqkhIyMIvMfwE/9nM4DS87Cv7nsZ6bypyaqEdj+BNhf0lA26hEg7YBGjKkETl7/doB03U1ILdgCfrbVKV5362OaqU/NB6sJTKkrLR9vAmqli7yC2RyUCsheeq3WYAl48NrA8Mu4hUOnYnvqkTumdqxJOdZEQ+mzisf8JMsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFe9JEeiikZ41Rh+6qXHvwt1hqFBkD//iqrzhZsMAj8=;
 b=OjZyxX1SaDrdElGz53rxPexK+dljbCzPwAx/EyRAFjuSnZw7kxl+wPInXmgLj4iC6Mtb1Ec61tWMfSPusZDgzp3b9NCxx3JjQ/G8UEevhzo/eO4bMJ3tu29tod5yy+cpBdGMgIZtIa8NvXk9eXp3eDDcei+6TWoR1SpdsQQ0EGXzHvdaT573pWhsZFIIFS2XkNGoQsMEqOoHrIRwpj+a1eix4gQDZ/VuJs2wznnDFKVdWb6Gu5uyddhwzgR0JM+dLroXCpG2Y7UJEwKb4y6CrFYR3yc7qybLO30fLWx74KzV1Mjl45S2fFsZHuQJIVLJOjPOHlaPewmT2ZV4eGFuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBAPR07MB6568.eurprd07.prod.outlook.com (2603:10a6:10:18b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 11:12:05 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%4]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 11:12:05 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: Yi Liu <yi.l.liu@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Topic: [PATCH v1] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Index: AQHdIpiwj2+asGS6SESECAGeCbz3Y7aL6wfQgAGpLYCAACrDAA==
Date: Tue, 4 Aug 2026 11:12:04 +0000
Message-ID: <77fc60ab999ae660f3c49b28b814f18ef8cb3cdd.camel@bull.com>
References: <20260802160408.645484-1-clement.mathieu--drif@bull.com>
 <IA3PR11MB9136485848B1212FBC2A440392D52@IA3PR11MB9136.namprd11.prod.outlook.com>
 <bd68b771-91a6-483d-8f5f-45b84cefd26c@intel.com>
In-Reply-To: <bd68b771-91a6-483d-8f5f-45b84cefd26c@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBAPR07MB6568:EE_
x-ms-office365-filtering-correlation-id: 85b0aee1-9a5c-4418-4425-08def2193762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: VoTsU/Nz1c7em+rUmIMyhN90BgCNrnfMDJUVfXbEH6FpDIsv40e+sGgyMfCweV0nr0SmrtCZGCbmfoGGbRQiB1cg1IH5WDy7RNkd9fzRquEOU9lSwRhTABgcWrGBeYy8oMvPgY54UJTcH8AAy8RdNdnhm5+YOfna4giYTRzhphkXelirk8VeIYAqicw5e0ycCyOxIbUcw5E60ECkKD+px3s2HEuBDGfphYPWJ3kqDDTcagjVZxOyBwzF94XO28HKowLxsiO8U6Jmx3L8E36elgXdC2GwP6rnFtKGgqnEq+FXCLBCLb6fF3+t3XFAcL+Jg8BcFyFgfAC5Zop0lgyfBrDwfd06nJ97zJsJMdhkXXcLSk0kg2zcdRL7jrpjS/6uXYrsNW2LGHga7py8uxlyohzO6m/5uP3funTCOn92kTFZYtnQw0KNJScLeCJ6a5N65kD+mqi1ZX/aq3LZ0w7Bj6VfdXJhkQLw1U8vzb17LxEbrM5qwRarDk79gfRIevLH2OLgHZxUwz7cjEocp14/Vc+T/uJACkwUIfpJbYn36bYJFQUgUeEgsOZ4l+Wl0AjUMDqrcGUiQAArvtJT4P99iGJSdemOZLIHJh16cIsHK8cwlonPYJrEtI6xNGvrrBgigQmPyZCbKedOZqvOQ45YuJ2vN56To1Frkk08fO4LNkiWmCsZY8QeONgN2nZfbQ/r4MsIBXAnkkdu7ITSpgmTQg8u4NimInj8HuvRrXt2dmk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(38070700021)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnI3ZDRQajlObjlpbUlyeUFHZDRPdGt4bVZxVHhlVHdHK2p0VURWUUhYeVJZ?=
 =?utf-8?B?UkdjVG4xRmdVcEM0d2xwdXprVzdFdGVlY3FYZVhyaEVyYWU4VGJBWFh5dXQ1?=
 =?utf-8?B?UHRYSGR4TGJYbjhQUE0xU2xOMjdFNS9YMWxPQm8vVVlJN3YrSzIycWI2b1Vs?=
 =?utf-8?B?cDJCeGJqb21IckovV1FiZHE1c0hZUlQ5b0JXZGlrbEpiS0pWeklMZHd6endL?=
 =?utf-8?B?bmhkWVhjTFBoZkVQbHpQQ3pzUTRvYVpTeVJtMzQxNlhrSVR0Y2czdDlDYUI3?=
 =?utf-8?B?WUxRdUFyeDVjUytGY0JZa3I1cEJKRWJUZnN0V25Uc2E0QzIyTzVpQ0ZaM0NH?=
 =?utf-8?B?Vjdlc3ZYR3U5Q0FZV29EUHR3bkNDSUVzSm4wckh6cnc0cEhzNi9ROUIvaXVQ?=
 =?utf-8?B?UExPaFJmajNMd0JVR2d4blpvcXNmWGtmN0hkUzJEM0ZDcVI5NkhWMGpMMjhs?=
 =?utf-8?B?eVo1dDlqZkJ0K0t4WGMxL2ZoVmNhcjhOaXNmMjdkbndiMkhNRTRLaXd3WjRW?=
 =?utf-8?B?cjFKNXNNUU5vOXJZR3cyL2hiQWFCMWpOZ2ptcDB2VXdCanVOMjROTU1nN1lI?=
 =?utf-8?B?Smh0aXI5WEpZc2NSbmlCenpRZWRWdVc2eHMzY1JOMElkd21NQ2dvRC9hWFFR?=
 =?utf-8?B?WXZUU3lvSlB6YmprNHVHR0p1Rno0a1ZEL010THgwTEk1Q3JHenRMZ1IvNlho?=
 =?utf-8?B?aHhiTngxZWl1SFBLZkUrcjdmZStxejNWdzhSSzVyVThEQmtwWUVWOFNIR0Jk?=
 =?utf-8?B?amh5bHVXYkFCa20wMitBbXViQkNSM01XbzVxYXo5Y1VNRmZjRzBSZGlUUTBv?=
 =?utf-8?B?UlMxbGpoNWwzNE45ZEQzQ3d1M05yZ2w4WC9IaFN0Skk1TmZWSmthZ0M3dkZv?=
 =?utf-8?B?NXNxSll4OCt0UDBScVpjOHREVURWbFlSd2hkQ2lyVUhqVWZzZFhLLzJuQTYw?=
 =?utf-8?B?UXFJenJrQ2c1VXlFNUdzWkdZZFlNU3JxUGJYL0tGRVpEN0pJQzhrY0tib2tz?=
 =?utf-8?B?RERVNGNnUm5EQkFvM2U1b3ltaUNOR3plODhKdWsremJXdVhpd1lLYXUrSExD?=
 =?utf-8?B?YWIrRUhnd1J2c0xGUUJYMGpOSTNYN3lMek5JQnIrRHlEZTBFZUphUGpTMjNP?=
 =?utf-8?B?SWxtZW5PdEdqVWx3OWo1Y2ZkTTVENnNUTlc1MXljdW5pemlscFF0Q281Yk5P?=
 =?utf-8?B?MjdudDFuWFpMdnExT2FOa3hhZ1hFQnhHMlQ0MkEwL3lQZlBsSGJ4MkFqOUl5?=
 =?utf-8?B?RG9RazZUWEdDTTU0Zm0veDVnOVdubnBMSjdWN2p6em04VkZudW1sQ1JmQ0tr?=
 =?utf-8?B?aThQWmt5VFlMRCtjMFFaZnZvazhTcUFZM0xocHl2UklpbHJTSlB6eXBhdTVF?=
 =?utf-8?B?UUkrQVozZENub0FDMWJmTENjb0VxSFRBdkdTNDNzdlVwWkNFejYzb1V5RXZs?=
 =?utf-8?B?dGJSR1BMZytRNGNLRmNrejhaU2pBTzZnSUxKdy9jQ3duZFNqNEdsTXRSYitI?=
 =?utf-8?B?VkZXMjd0UFJuVHZTb05sRlQxUXM2WjBzN1Y4eHlhbWl0Qmo5ZDRJUUVoTE1M?=
 =?utf-8?B?YytKUkpZSDRsbEN1YnBhcGZPY2k1dkV1M1JKMVEzY0tHeVh3ckp0VFJoNDAx?=
 =?utf-8?B?NHhlRk5MQTMxN21kZDNJbnByMDRKZHhDNE9NZEJOUnIxVjZFcUsrZXVkdE9q?=
 =?utf-8?B?MWhta0RQdjg1NVo3OXhKSVhLUUMrQjRCQW5DV1lhckRyckFwK2tWVDg4cUY5?=
 =?utf-8?B?NkFsVjZOUCtNTlo5VWZrZVNuMlplSDV4aXh4UnZ0bkQ1Vm4yNW1wZjRBZm9L?=
 =?utf-8?B?dVVHWEoya2w2MG1wVTZGeVJ1MVVZVzk1aGdxQTUwTktzd205US9KRUFpaCtS?=
 =?utf-8?B?NkV3TVU3aFhhQ2MxMTlqQ0gwYVVXRmpvamZTWG5XdnBZVEdIbmwxeDVHZ1NJ?=
 =?utf-8?B?RnI0ODEvb1NmNkhoVnQ2Y2k4WHJyWDZmeFd6dWt4ZGhUdHg2ZHFUd0FQdHVZ?=
 =?utf-8?B?c1dNRnNiMHcxVEtLK00xUTVGQ1oyTi9aek8wZHFQL3dPNllnOWJiMFdEbWMz?=
 =?utf-8?B?MDdocTdxemhsZUJFZkFSL2s1NERkYUJiQmsxTjNiN1hmbjNOb1BUWWc0c1Fx?=
 =?utf-8?B?cE5qMkxXL3VEQ3BqbGRMek9GS0VibGNHN0NaeWJTWWc1NlpWMHpQMlpwS1hQ?=
 =?utf-8?B?T2NCc1Bna2YzUEpNaFBEMHZnWmNMM0pnYjJORjNzcWljb0ZYWGhHeHlldmVi?=
 =?utf-8?B?MHJhd2hUQW1tUEZkaEhWMEdkMmE3OXUxNFJBMU51b2UrWDZJbFEwcWlFVTlv?=
 =?utf-8?B?QzZCNHpKdUg2VDFGVVVpUHBRRnJ1N0xFR0NMVjd4akM3MldQWFZITGtpQ2Z5?=
 =?utf-8?Q?IiUEyyZZMVkV6B2vE49nLXW0+HDguR17sRHIU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D9647025C206D4CA0E4CC1D3E501576@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iuE9bAAM9MpAD49lTtezSbmb2rg0hI2IubvgUIC/k8MLBRYr7+i/fcZ+r00zbeEKn29kdesZGPfXzjsZyyOnWj1zAHTqL0P3OjiFQD34cc0fZ1oCZigelKHE37xm7YQ9dgtbe4tW17dedqoxeQTSSWv48oQ55oyfHiaAIShNR70UDOa3/1hoVlfgp/qT3Drf9YhukSkvPOIeJMcUKgsNNa8W/7EefKmfqWtLduQfYrDoUopvnvTQU3jfnIEXVxDC3+qcGdQ3MjmQvDsNb/KTgfXbOH+3PWCuN042TNaXa49z9cCy4sxw46EUuat1Qai14liZX0DjJL1/KZw75KJzbw==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b0aee1-9a5c-4418-4425-08def2193762
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 11:12:04.9974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y39aya9h0+VfWPVlwj00IjT6EqXq9KXaWxxM0kGjO8ETJWhc9C9P+/mMOOGmvJPYPXmLzR1xYqVTn3uu8Gs9RJGM2CUswXW8hSctsBLQSOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6568
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQpPbiBUdWUsIDIwMjYtMDgtMDQgYXQgMTY6MzkgKzA4MDAsIFlpIExpdSB3cm90ZToNCj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIDgvMy8yNiAxNToyNiwgRHVh
biwgWmhlbnpob25nIHdyb3RlOg0KPiANCj4gPiBIaSBDbGVtZW50LA0KPiA+IA0KPiA+IA0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IENsw6ltZW50IE1BVEhJ
RVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb21dKG1haWx0bzpjbGVtZW50
Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPiA+ID4gU3ViamVjdDogW1BBVENIIHYxXSBpbnRl
bF9pb21tdTogRXhwb3NlIFNNUFdDIHdoZW4gU1ZNIGlzIGVuYWJsZWQNCj4gPiA+IA0KPiA+ID4g
U1ZNIGluIExpbnV4IHJlcXVpcmVzIFNNUFdDIGFzIG9mIDc4MGRmZWQ2ODg2Mi4gVGhpcyBpcyBm
cmVlIGluIHRoZQ0KPiA+ID4gY3VycmVudCBpbXBsZW1lbnRhdGlvbiBhcyBpdCBpcyBhbHJlYWR5
IGluIGxpbmUgd2l0aCB0aGUgZXhwZWN0ZWQNCj4gPiA+IGJlaGF2aW91ci4NCj4gPiANCj4gPiAN
Cj4gPiBOb3QgYW4gaXNzdWUgaW4gdGhpcyBwYXRjaCwgd2hhdCBhYm91dCAnQzogUGFnZS13YWxr
IENvaGVyZW5jeScgZWNhcCBiaXQsDQo+ID4gSSB0aGluayB3ZSBjYW4gZW5hYmxlIGl0IHRvbz8g
TWF5YmUgaW4gYW5vdGhlciBwYXRjaD8NCj4gPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxbY2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1
bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tKT4NCj4gPiA+IC0t
LQ0KPiA+ID4gaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyArKy0N
Cj4gPiA+IGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDEgKw0KPiA+ID4gMiBmaWxl
cyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPiA+ID4gaW5kZXggODI0NTQ1MmQ4OS4uOWYyMTYyMmE0ZiAxMDA2NDQNCj4gPiA+IC0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+ID4gPiBAQCAtNTEwOCw3ICs1MTA4LDggQEAgc3RhdGljIHZvaWQgdnRkX2luaXQoSW50ZWxJ
T01NVVN0YXRlICpzKQ0KPiA+ID4gwqDCoMKgwqAgfQ0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoCBp
ZiAocy0+c3ZtKSB7DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqAgcy0+ZWNhcCB8PSBWVERfRUNBUF9Q
UlMgfCBWVERfRUNBUF9QRFMgfCBWVERfRUNBUF9OV0ZTOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
IHMtPmVjYXAgfD0gVlREX0VDQVBfUFJTIHwgVlREX0VDQVBfUERTIHwgVlREX0VDQVBfTldGUyB8
DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZURF9FQ0FQX1NN
UFdDUzsNCj4gPiANCj4gPiANCj4gPiBJIHRoaW5rIHdlIG5lZWQgYSBjaGVjayBmb3IgcGFzc3Ro
cm91Z2ggZGV2aWNlIHRvIGV4cG9zZSBTTVBXQ1MsIHNvbWV0aGluZyBsaWtlIGJlbG93IHBzZXVk
byBjb2RlOg0KPiANCj4gDQo+IHRodW1iIHVwLiB5ZXMuwqAgSXQncyBzdHJhbmdlIGd1ZXN0IHJl
cG9ydHMgU01QV0NTIHdoaWxlIGhvc3QgZG9lcyBub3QuDQoNCldpbGwgZG8sDQoNCnRoYW5rcw0K
DQo+IA0KPiANCj4gPiBAQCAtMzcsNiArMzcsMTIgQEAgYm9vbCB2dGRfY2hlY2tfaGlvZF9hY2Nl
bChJbnRlbElPTU1VU3RhdGUgKnMsIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsDQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsNCj4gPiDCoMKgwqDCoMKgIH0NCj4gPiAN
Cj4gPiArwqDCoMKgIGlmIChWVERfRUNBUF9HRVRfU01QV0NTKHMtPmVjYXApICYmICFWVERfRUNB
UF9HRVRfU01QV0NTKHZ0ZC0+Y2FwX3JlZykpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqAgZXJyb3Jf
c2V0ZyhlcnJwLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiBT
Y2FsYWJsZS1Nb2RlIFBhZ2Utd2FsayBDb2hlcmVuY3kgaXMgdW5zdXBwb3J0ZWQgYnkgaG9zdCBJ
T01NVSIpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+ID4gK8KgwqDCoCB9
DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqAgaWYgKHMtPmZzMWdwICYmICEodnRkLT5jYXBfcmVnICYg
VlREX0NBUF9GUzFHUCkpIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJw
LA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkZpcnN0IHN0
YWdlIDFHQiBsYXJnZSBwYWdlIGlzIHVuc3VwcG9ydGVkIGJ5IGhvc3QgSU9NTVUiKTsNCj4gPiAN
Cj4gPiANCj4gPiA+IMKgwqDCoMKgIH0NCj4gPiA+IA0KPiA+ID4gwqDCoMKgwqAgdnRkX3Jlc2V0
X2NhY2hlcyhzKTsNCj4gPiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gPiA+IGluZGV4IDkyNGU5
MWNiOGEuLmRmN2EwZWZhNmUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj4gPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0K
PiA+ID4gQEAgLTIwMiw2ICsyMDIsNyBAQA0KPiA+ID4gI2RlZmluZSBWVERfRUNBUF9TTVRTwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0MykNCj4gPiA+ICNkZWZpbmUgVlRE
X0VDQVBfU1NUU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgNDYpDQo+ID4g
PiAjZGVmaW5lIFZURF9FQ0FQX0ZTVFPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxM
IDw8IDQ3KQ0KPiA+ID4gKyNkZWZpbmUgVlREX0VDQVBfU01QV0NTwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICgxVUxMIDw8IDQ4KQ0KPiA+ID4gDQo+ID4gPiAvKiBDQVBfUkVHICovDQo+ID4gPiAv
KiAob2Zmc2V0ID4+IDQpIDw8IDI0ICovDQo+ID4gPiAtLQ0KPiA+ID4gMi41NC4wDQo+ID4NCj4g
DQo+IA==

