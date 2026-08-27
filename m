Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEA3C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVhr-0002zR-RT; Thu, 27 Aug 2026 04:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVhq-0002y6-Bn
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:43:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVho-0006uc-19
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:43:30 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R6nw2143919
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AwEnIvKejSYNsZw2U2+fayxSeMSAewks083pgmQCYBU=; b=ELNsoZc9ihe9RR+t
 obuyPbV+BoO4+WDjqn8qfbN1FSyP9xNgJghbb73hYprwW2ahD0J0epXrO1LLyEhC
 ldm7wxvpTnFCtoCL+u5/Tm6UYBQ7aJB0vbp+esznHyYxpHbKp1xl8vegiQgwMRG7
 gBXgZsPCJEbiBjge478V/cIfYz/YjXwZpZDJfSIHOBw1bzj2Iodwno9JddMyLUpN
 jB0c7IE7JP+lUtx5M/H7PEv0wn0K2pafx984jmsgJKFpkDCZ/0BKgcX+GE+91Njc
 8NvoCFtXipk4f/nZVOlAN1XDxgJTj/+MiG4cAdnhBZuQ3EpzFgoZoUAwXkYhOAq/
 x8jscw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gab7t1gt3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:43:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0e702df8so6493601cf.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787820206; x=1788425006; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AwEnIvKejSYNsZw2U2+fayxSeMSAewks083pgmQCYBU=;
 b=UqgRRxMo3MbK02aCWAC8A/rVfmNEPUMU7dBRliZYHjZx/O7bYMvfiCTyOm+DOe1F+z
 NKlRXedXq/agM388feXyiOcl51nQWHqbObNi5vuvdxPkwesRnb9v33SVsSXIorw4z05V
 u85YSR0zIgUJEJNZ23HUJ6YHzZjxjFoEv3+MLyURGZ2ErNR0ZHyd2TZb1D7k2fSI7eZ5
 pE2wWq7yRSkCC4hsMD2gAAVbhy7pjOtEdOQbGq2UeI0mgpMvlHfDbIQLaaIzl+4xvHzO
 m1ZUOPNxWOMkBv4M0Miuu9UeslsPfgIuFpv0TijjPnBy0DxZe23iPK/+WyCSPXnrGCvB
 iyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820206; x=1788425006;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AwEnIvKejSYNsZw2U2+fayxSeMSAewks083pgmQCYBU=;
 b=K6Mi3nq5XcQrZYMK6jzWLfBOERfzQDNV8blp66+LMSyLUU7uS/Dv0nkY8rSDayUMMh
 kGL6D3i9w7rx4WDynSBBf1wBpK0RpRiw7d10pJlZ8YSrKdVgBuLbBi0K2Usy74N4Bxys
 4bj+16AhJFl2cV8mj9suYImf/mj+VVWPjmT3btQfsZqrRVAHuLbm8JKDMdMzLBmoVGL9
 6PzTURN9xqfetSAgw+vdPkX2cE9fQ9dBKAUmUgt4csbaBFS1jmuxEIzktC6KHu2Xdh6c
 n0wobbMpaU6AuAOqTUB3VUacupPr6UaMXACU1RODlhAJmu2rc64FYvh+YgfFdgaVzFIJ
 +2Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvbNSnv+5QmZlThXF4xRmMXV2WpyTWEsbS7AlRLz5yWJeK5v1Th3nYPaWkoAWTWxGUfhxCSkwUE5z/@nongnu.org
X-Gm-Message-State: AFuF++mWnuFQxTq6JzZo7fVCU0X2QVfUoFQnDM+QFB/DLZGF/6gPBGav
 S0SmNGQ0rFkX+IdWXHH9atvPyTJKZnZyt1ow9npN3qiIHYNkPDl8Ct7XUzJohJtf+KdCNOn/mFX
 6+Ypdc6Us0TqaPygWItjMxyp/7yyfWus25xLTLrgMoY4A1FJ4YFl31pN8YA==
X-Gm-Gg: AR+sD10nOkeHWHSm8GIivU789DyFN1qFfdMBSOBr9IBqoXC1W/0Do4GkJT1LKWbU3uU
 dS1fBpd0ZIM0+Yx6fXE7xlyLDednOIXGV6FaW2fQesMWKx3/WImP4Q5pWijm+RgYB8IyNnmZyAT
 r43TtvLcChNmWkrpQxoGI16s6ViIgD1gjWlI468zeHmJHFALSqruKotmFhq6UwGm8NrjLHHmMYG
 kcsL4nTsK6bSvQnaMr5bDve7OoEbyafSrrHxi3qSQ1AMqa980h9JDwDDGEAd7+50G5BzMLxFbq3
 m3RzFozyDYfGc3hA3FmPQl3K28hdMOpFKkxd6R1CKSILzay7vgjQljBnIvcE20qe/x9Mrzqx8eU
 6yzQR//6z+mvfzAz4Xt5yXmIFYXeOAMN0+tVHQ7swKkSvXKrP
X-Received: by 2002:a05:622a:15cd:b0:52c:ce3:6428 with SMTP id
 d75a77b69052e-52e422cbdb4mr125107141cf.16.1787820205769; 
 Thu, 27 Aug 2026 01:43:25 -0700 (PDT)
X-Received: by 2002:a05:622a:15cd:b0:52c:ce3:6428 with SMTP id
 d75a77b69052e-52e422cbdb4mr125106791cf.16.1787820205377; 
 Thu, 27 Aug 2026 01:43:25 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942298fsm36548445e9.1.2026.08.27.01.43.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:43:24 -0700 (PDT)
Message-ID: <a18dd511-2be8-43b7-9f3e-c4248a5d70de@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:43:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/43] qapi: convert trivial intro sections for
 error.json
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X6Bi7mTe c=1 sm=1 tr=0 ts=6a8ff8ae cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: s-aInF4zMhutdVLRWT2UYdUd7zF3TI69
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX4bt+EPipBc5f
 RSAZ+YJ3fpd0vQun6z2vDaa/ZQ1SJj/DsYObJnwIejvpn/YAxgOLP/pdpDtnL0ip30cStkJYs6f
 ZXGnydxaE/6wGmhR4Rpaob6JGF2PCds=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX9/HLR9SgJDfZ
 cj0rCYyiBsGHA5V0/a+ZAHooJ3GM+dDP/ayaIm7p6uiEo0M7WzafvhsuUuXy1x9xZo98q/PfGPA
 zuBte135v5AvGJmOEKO2X5G8KX8CZGPxIgNJ44CWFEjOKcdbjtl6IGGa5p2IlPb8v6sbppfeM1o
 mSw33fvM9hiGPLyXe1Vr6nX6cOPFBGHxBLAYvfE8fcTQk1iq7EDYnjYVF6T9iSzCAL7Ika3f0EN
 5SBiKHRuY+8RxQrEnA2ipQf04KeYRHvlnPjy5UUiDKZd1YoVExyzUA2u9qdH36k7cNEvSLaETbu
 SlZyEMeaczhaqhyph9ohdzAYqhZw0BmNcLE2aHls+mQ7D2KwSl83YoxyHzQI6b4CWRAYD++HeqX
 /6MqkJmkftGxEhkuJUnQ6JtOB5blGVjsVesbv/yLOkq+TUM7y2AK961cOGgO5xJT7o2mN0Vuf1Q
 KntY0IxN3m/Kp2XdUsQ==
X-Proofpoint-GUID: s-aInF4zMhutdVLRWT2UYdUd7zF3TI69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/8/26 21:37, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/error.json | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

