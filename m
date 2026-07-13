Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECA9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj9vL-0006t4-VT; Mon, 13 Jul 2026 02:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wj9vG-0006rQ-UR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:13:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wj9vE-0005eL-86
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:13:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D3AFBs241699
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 06:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P/IMXcUmMiGrcKUzVTRDJjn3c7VrwXkTEa5XQzOl9So=; b=K+kebJ1OMalfLK1m
 tYwGBkRjwCUxFFnNvPFn/ewS3F8bYIlKFhIDz/pG4REryelnFUzTrWyki3gf8u3B
 PK5pAgCe2V+xXnutoRm47Cl6qPJ6RhQp23j00OagvRgbVbh0IkqjwGaX57wkuQw5
 CJbwumURtavBG2u47uRhshW4rOR4HJzrRkZDr121fPRUABYxqW7pt3k7kDH7X3At
 GPgwZ+kTVo1gF8qz69K7fA3k4YYnJuNSidQTR+tcB5NeyOO3KMITfHxPmD465kja
 lyYMu/Sn/3ktuTUn6k1QCdt6DSpNVBG65WU8+qOBpObEXElWW3lZkZiVVFEe52Po
 Bblv2w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgmmvb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 06:13:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c075c1e25so28749231cf.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 23:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783923220; x=1784528020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P/IMXcUmMiGrcKUzVTRDJjn3c7VrwXkTEa5XQzOl9So=;
 b=JkgDnVkWPGHrrkQqEaA87JkAmixvoI90my6KQdHp75vKHpGMWrb+f1Ie7+GZZf2I2G
 7qsvApIPhqVNvQhhh1555QRDuxEutsCWaXACThERrBPTreUaxJOHVyCZywpoQszo+ORI
 7SshJu8jPPTwe5k6IShuxMB5ACskwKh5uUd7vy143zokMaxB47igoyWyiSv71pzL1s0f
 KK2PjS6FklcFjimIlPVSTle8pgkY+x1xYLwLSRx2sTSWL77KDOwty9qBal8/omNmvTri
 lJ43cuiidCEExaQhy3wcGNwy8z5otNMNka1eWvTwr6Cpv70vfTTp5iI+S+TLva39CsHG
 Xitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783923220; x=1784528020;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P/IMXcUmMiGrcKUzVTRDJjn3c7VrwXkTEa5XQzOl9So=;
 b=jxKRrxJdaSzk/n3weMnducLt8z+Sbsl8pXjqYsSEgzUUyldj050bR/uzAHNL8+69v4
 z4R3E4stSOZkboivUWYMcPIfjIXjVwCxNnpNu49sADGk4GsIQByAcqBDYgKdcvDY/wIV
 t2vNUsoHvMQHAUqQgkMhi0RsmUqsJJJ7zpTU3RzxLxGZyHvs1dbf51YVTujItFK8sxJr
 khAlfbVs6OXbwF2r6+BcUBnqAtT6pQpfta4j41JO+JuA6AByXJyNnQqj+WG+teCvwZi5
 dJJtD/jH8HTy2CAwxIe0Chp/NC2D+IHU/ERkin6LdoeqlFrWRDyB5WnzAfKvbhN2PHRU
 EJMw==
X-Gm-Message-State: AOJu0Yz2VhQZlATMEV03GCi9e6NkVz58gIGOmvAk46XFjdKS/GxhQhO6
 Cr3AtSLrtdaSZ1Ca4jAXSEtyZOmDHDv6eTT4vk7tCHNYT+WwGh6CZ9LcGosATEPnw1PaJxcgkGx
 6qCPnxNKQ/ZOgjg2FECesY4AmFKQD90E2O/bwoVDw4zEwsfeginoEHBXFaQ==
X-Gm-Gg: AfdE7ckZOoIfRyFfzSCKMqYk9mDXCyC+2iWG+oIHUomKAV8ulZ8s17sU+KeLGcskuzx
 J0DH527UFLjSXydUGNOPpmvXlwLXdu99ZvFxxR6HcUkHc5/ugVMmSVL1Qq+Kvz9FgGyWFjazOYT
 ay8R6K968wWTX3kaMgH7cJOrx3RLrForIEzoRh/6KjRBxMyw948j2fiPYB3zuVZNLiQDiSwJwwz
 jEvYgGLcoa3t/6jqPeNDWLAZ3eNmzMf0nS1H3q39uaLqrKv/V6E/LYI47HArwB4/pZXicI9VPug
 zdxj/xViUgoXPsOxFQ9AXUSeJsiTjA0JTrclSzD8DLIPvXOoBanO1LWgZq2KqJs0fQj2X/OALxL
 wGPBcv46cm+CtfRVTqJZxsSGam2BAbijvpuOx/Rvd403KKCka3ZrBrEr/bLj9Cw==
X-Received: by 2002:a05:622a:230d:b0:51a:8c9c:7f3d with SMTP id
 d75a77b69052e-51cbf26c037mr78137241cf.64.1783923220583; 
 Sun, 12 Jul 2026 23:13:40 -0700 (PDT)
X-Received: by 2002:a05:622a:230d:b0:51a:8c9c:7f3d with SMTP id
 d75a77b69052e-51cbf26c037mr78137161cf.64.1783923220186; 
 Sun, 12 Jul 2026 23:13:40 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm83028276f8f.15.2026.07.12.23.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2026 23:13:39 -0700 (PDT)
Message-ID: <65079ad4-3ab9-4ad6-b683-09d46c72b266@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 08:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark "vhost-user-scmi" orphaned
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, mzamazal@redhat.com, sgarzare@redhat.com
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-3-armbru@redhat.com>
 <20260711035848-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260711035848-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA2MSBTYWx0ZWRfX/Sl1+128r0YQ
 tFeIOZ+IXy0iHhGqEc10lwbPTlwsm41jCFZAU2W8rIhsRsau96R7t6q/pP8CRIRa/kWjjkXVj2r
 Krv2bOJul+HfIy1cm7eIaKHsuRmrA6M=
X-Proofpoint-ORIG-GUID: CzjYRfKH8uh7_PeCM_D1pmv4lNMUKXA_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA2MSBTYWx0ZWRfX5k51IkZ+OBJP
 0axbFIQV7ACy5ctErUjv8TLSGK1th52prQ+G/Eyw5GQMU0Jk0Xj1e8R42aHAa//EXifPp6XO9HY
 gmagL3AVjbkyucAc8uefuY/j/2f238gKkg3my+3b0fhtTzgu+v1tvFMfrQhwq9u5MKnE5Wmd9V+
 JEb1cXMTtlU6l+8tUJi+o0lCmS6NEi8pTxvpX+slx3G9biPqw0W14k1ZPpqUhyTqibwPFs6tvmD
 LK0X23QPi5agSChc7pb/YTLkHToM/7ytS2cYrWAPXDUrklPMrcId+eBHyzjfiOPVB1yigzpiZGd
 5G3QWXygyuNpYjgx6+C1EIQjWBddKSx9Aqk9ky1vlR7isBUnfqpniNrcYLNgH7G8UN8HFb1mYHx
 5XHfRQbAF5sgETb/7oaBSMjuSJcCfwv4ybIN8Z0Vf16cviWmWXSFn9iLTXMwD5eaMf83tdnnxBp
 MUSsKIF2qHhroI/Av3A==
X-Proofpoint-GUID: CzjYRfKH8uh7_PeCM_D1pmv4lNMUKXA_
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a548215 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=zdFt2-FTdirmDjd2dogA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 11/7/26 10:00, Michael S. Tsirkin wrote:
> On Fri, Jul 10, 2026 at 01:43:05PM +0200, Markus Armbruster wrote:
>> Commit a5dab090e1 (hw/virtio: Add boilerplate for vhost-user-scmi
>> device, 2023-06-28) added the section with S: Supported, but no M:.
>> This makes no sense.  Downgrade to S: Orphan.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> 
> No, this makes sense. The reason this section was added is so that Milan can
> get copied on vhost-user-scmi but not other virtio stuff:
> 
> ./scripts/get_maintainer.pl -f hw/virtio/vhost-user-scmi.c
> Milan Zamazal <mzamazal@redhat.com> (reviewer:vhost-user-scmi)
> "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost)
> qemu-devel@nongnu.org (open list:All patches CC here)
> 
> Pls drop this patch.
> 
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aa2df9cbe3..4d558ddee9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2622,7 +2622,7 @@ F: include/hw/virtio/vhost-user-snd.h
>>   
>>   vhost-user-scmi

So what we want is to add here:

   M: Michael S. Tsirkin <mst@redhat.com>
   R: Stefano Garzarella <sgarzare@redhat.com>

>>   R: Milan Zamazal <mzamazal@redhat.com>
>> -S: Supported
>> +S: Orphan
>>   F: hw/virtio/vhost-user-scmi*
>>   F: include/hw/virtio/vhost-user-scmi.h
>>   F: tests/qtest/libqos/virtio-scmi.*
>> -- 
>> 2.54.0
> 
> 


