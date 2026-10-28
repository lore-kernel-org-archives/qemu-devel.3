Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE06B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YHIP6k6u;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OS/0EIFt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAcs-0005Fy-SN; Wed, 28 Oct 2026 16:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAcV-0005DZ-SE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:51:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAcR-0005kJ-US
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:51:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPgIT1580297
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /oekYVVq3nE/weCVogNCmjoEoUAJgEM/k26Ub8/q9Bk=; b=YHIP6k6uF706cdQg
 39zDjTg+fJavoSLRkYU1Opruvg1IZvQzeD1HzYAA0JmTY5aMTWhRzNDYxpciEZzf
 +UefSKobdSBOIMDJgI9pr/XKZpyutzXd+0hxG34iQbl332fyu7pP05RfQf/0nQfs
 elbt8eEqfOwyD3Cv82f5Q12XWABcuuMzMYVb+ROrDTyQzOB4JrE4+8B+6HJgLsLF
 Swn4ZSyMpFJIk6p9SOoRikvlK9VIw89OKLTehoT+m24GFEeZhI2+WyNdKOQecS4J
 6B3uhOXalQagYlI5vH3e9yXx2B9LO5FwPTCZxX3pvyBqe46bb3ViAYpEvNEyM9MH
 la6/DA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkp8q2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:51:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36998507c13so2076798eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220693; x=1793825493; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/oekYVVq3nE/weCVogNCmjoEoUAJgEM/k26Ub8/q9Bk=;
 b=OS/0EIFt/qJO89fPnRw3UncwQFFaQbccEBCwFV9MTE+xiK/s4axN4/2ILuDhh2cvaW
 rgwWIyqaMOoWDHHaj+KQ3kZqrtTqGr3cdLSPtqJ+3lx089x0o9LMyOhIXL0RX8SQRg64
 BLgFH6dPBk4eCgVuhNZFL9pWKJstgBX++ifDxw7uUmR8SBf/PO85Gh8QuJOa0tRsTHYF
 md353AK0QBlQYFugoI4RgAPXDY0yBXFzKvxITQ40w/SwYKK5thxRchxcrqHVvXjW0611
 wh7twPzAIqSX3I67rTMMVzvFmcOw6HonG/O3P9aotQKjObcWJ/q2cIHw6gsP3fouIzZ/
 GMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220693; x=1793825493;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/oekYVVq3nE/weCVogNCmjoEoUAJgEM/k26Ub8/q9Bk=;
 b=JbPKbijpYZ8pyu/7vRCdJCzdryeOK/7H3s+ATmLWS/oUbNXNj5hDpzKExL3ebGBfGo
 76HYcrxFdB1h8EeHOxeEfDkUwpXjCmruMGfvrN6iwLbBg1bxsUE7HNiN9znZhq3/Z25L
 JHgrQkm9NsFbIkpZlhVS9DnDRPkhLR/cxD/Lr2XfTpHGF7ajPjWT+rpUtjeqbSOyeqxo
 M11KOB0T72iNkxxcEksYEdXou0zhptppNfCWdGSOeD7tgvY+8HDr0csiw2iEni/6YrPe
 mu8pmD+G/ejBlDqi/W1WJxMNEqG4ZbuIVTZvcX7AL2T7hk0mfi+rp5QZnwic34pL0/06
 6tnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsfdXSgTzSZuxGabpkgiEpdCaIIEiMqvKEJeq/UOy0RbA1HqTM3y8WTJa8cENy9fRkQ9u9qUYJomvn@nongnu.org
X-Gm-Message-State: AFq9FYIujBREZNW51VW6dQFw8X9B+ffogfeyDAWf53fx7xtSAye0+O5G
 6ZfdxgcZ85hD8oJDWTvQsxj3mOu7Mx5nlWm969a1QlqEAERvM5wkXHl4c0kg5K48/cnawMHD8+P
 bj1C5xImM3xVml9ImsQ/5vBZU3birX6ovFeaAbH/On7oPNrGiKEOdbpAr6g==
X-Gm-Gg: AYBFou2FHea02Vs6p2OtQ+KzGOzRf4gm/YPpjRP9L2/2+3XFl3B8wFVohQn1Ju7iV4W
 O0CMevjezJyF1iWOeGD1DIqENae762RdjGj0N6EU1RfVxZrTpZW19JVYSHqWLeFBmSZ93V9uzqK
 0kT0ADQrlREojQMa7FI7L1APz/Uh9/lYA8CI4nePWXq0V627+dBqwX4Eghtybmo0Wy0qwF2L4ia
 RP4c2KTd0eTTUSz8zFMtm340p8ldOE77YJiBoVsirAk/IXfckasMkjtRBzsFLt1sswmMOgvXBYz
 br/JQn2qANugJbjdYFlYXV9jk4CqmREFBLEdEdKBW6PQV3v7zqLiv66QZZi0K24ShnVjcwchTOF
 jxXUVvRawbwG2mHUfW2RDZoC5JpItm7RBEFKQYMBCmWhPbgyZGKxWCHlUA3JaqaNuCjFvLi+Ewq
 hNgRyLDoWhtzsqQsd7bd0jJglENyWN+EXsZ7Bi51uffbo=
X-Received: by 2002:a05:693c:6009:b0:361:1dd6:531b with SMTP id
 5a478bee46e88-36a203d42b0mr3163855eec.26.1793220693493; 
 Wed, 28 Oct 2026 13:51:33 -0700 (PDT)
X-Received: by 2002:a05:693c:6009:b0:361:1dd6:531b with SMTP id
 5a478bee46e88-36a203d42b0mr3163813eec.26.1793220692934; 
 Wed, 28 Oct 2026 13:51:32 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23908449sm9521686eec.11.2026.10.28.13.51.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:51:32 -0700 (PDT)
Message-ID: <30c84eed-3260-4f13-a3a9-2dda58c1a89d@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:51:31 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] hw/scsi/scsi-disk: register s390x scsi-hd and
 scsi-cd variants
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-8-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-8-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae26056 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=DVt02nBQAYtqlOVpk1UA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: cub2F-QdJrnIgOz5Pzp7yOONa34daZlY
X-Proofpoint-GUID: cub2F-QdJrnIgOz5Pzp7yOONa34daZlY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfX56Iqv3fPYpwq
 UmjpVqNG9trN5KfmRFkswodR/qA90HTq5OJDWR9zJrtDz92cBBP7q4HcKtr6+MnbkceXaZYkG/D
 XViXYDfDg0FECgm5MRY8Kg9p8494ElY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfX6pt486IVEamZ
 zdsW2IeYcBQ7Vw6JYGl0Ui8XZkH66fjvIL6Rqzv+HGWOLpx1heSL2I+Oxao5P+4SiWAmsaElUSa
 oJB98Lsni0kWnKBWNvlCDHGONOS0TZSGsmX3DGgMtw2mCtU+robxXfl0Cr9Ip/ay3a42IWoczNY
 aApAO4I00RJ4iGMjKvwR3HIzk3hhTkMAfmhadsA6DDD4iXgRDri9HFPMiuNkRoUI3un9Tv2n5Q8
 unP5op1psJNuV72H20oWiNtSTCPETs92phOXOSwJ/fpY6YULPhbzd4BoxbgyKo7SljsFSLZTn0d
 jfBvlocriDfUXryNLRkHytwZj5RTehpQuCwTlEuazq88khoYFSgduGuIdYaCKI3BFgE/fqBLbag
 DzzOStVVkNO73o2M04eYlOn5uEpQS3BDBgMtNA/zm4zxHh+py7evTEA7ZiuDQgghfIwH7mqWE52
 Cuq5gA3LLXG0i4gH7fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> scsi-hd and scsi-cd added the s390x loadparm property from class_init
> when target_s390x() was true. Register a second type for each name
> that always adds loadparm, and select the two with target_s390x() and
> target_not_s390x().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/scsi/scsi-disk.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 

Looks good to me overall, let's just keep the !s390 as a local callback
here.

Regards,
Pierrick

